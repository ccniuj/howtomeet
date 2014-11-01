class Admin::EventsController < ApplicationController
  before_action :set_admin_event, only: [:show, :edit, :update, :destroy, :add, :remove]
  before_action :set_admin_meetup, except: [:open_new_file]
  before_action :authenticate_user!

  # GET /admin/events
  # GET /admin/events.json
  def index
    @admin_events = @admin_meetup.events.all
  end

  # GET /admin/events/1
  # GET /admin/events/1.json
  def show
  end

  # GET /admin/events/new
  def new
    @admin_event = @admin_meetup.events.new
  end

  # GET /admin/events/1/edit
  def edit
  end

  # POST /admin/events
  # POST /admin/events.json
  def create
    @admin_event = @admin_meetup.events.new(admin_event_params)

    respond_to do |format|
      if @admin_event.save
        add_attendee(@admin_event, current_user)
        format.html { redirect_to [@admin_meetup, @admin_event], notice: '成功新增活動' }
        format.json { render :show, status: :created, location: @admin_event }
      else
        format.html { render :new }
        format.json { render json: @admin_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/events/1
  # PATCH/PUT /admin/events/1.json
  def update
    respond_to do |format|
      if @admin_event.update(admin_event_params)
        format.html { redirect_to [@admin_meetup, @admin_event], notice: '成功更新活動' }
        format.json { render :show, status: :ok, location: @admin_event }
      else
        format.html { render :edit }
        format.json { render json: @admin_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/events/1
  # DELETE /admin/events/1.json
  def destroy
    @admin_event.destroy
    respond_to do |format|
      format.html { redirect_to admin_meetup_events_path(@admin_meetup), notice: '成功刪除活動' }
      format.json { head :no_content }
    end
  end

  def add
    unless Attendee.where(event_id: @admin_event.id, user_id: current_user.id).take
      add_attendee(@admin_event, current_user)
      flash['notice']="成功加入此活動"
    end
    redirect_to meetup_event_path(@admin_meetup, @admin_event)
  end

  def remove
    remove_attendee(@admin_event, current_user)
    flash['notice']="成功加入此活動"
    redirect_to meetup_event_path(@admin_meetup, @admin_event)
  end

  def open_new_file
    meetup = Meetup.find(params[:meetup_id])
    event = Event.find(params[:id])
    
    client = Google::APIClient.new(:application_name => 'howtomeet', :application_version => '1.0.0')
    drive = client.discovered_api('drive', 'v2')
    client.authorization.access_token = current_user.token

    # Insert a file
    file = drive.files.insert.request_schema.new({
      'title' => meetup.title + '-' + event.subject,
      'description' => meetup.title + '的活動',
      'mimeType' => 'application/vnd.google-apps.document'
    })
    
    media = Google::APIClient::UploadIO.new('helloworld.txt', 'text/plain')
    upload_result = client.execute(
      :api_method => drive.files.insert,
      :body_object => file,
      :media => media,
      :parameters => {
        'uploadType' => 'multipart',
        'alt' => 'json'})

    new_permission = drive.permissions.insert.request_schema.new({
      'value' => nil,
      'type' => 'anyone',
      'role' => 'writer'
    })
    perm_result = client.execute(
      :api_method => drive.permissions.insert,
      :body_object => new_permission,
      :parameters => { 'fileId' => upload_result.data.id })

    # if result.status == 200
    #   return result.data
    # else
    #   puts "An error occurred: #{result.data['error']['message']}"
    #   return nil
    # end

    event.notes.create(file_id: upload_result.data.id, link: upload_result.data.alternateLink)
    redirect_to meetup_event_path(meetup, event)
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def add_attendee(event, user)
      Attendee.create(event_id: event.id, user_id: user.id)
      unless MeetupMember.where(meetup_id: event.meetup.id, user_id: user.id).take
        MeetupMember.create(meetup_id: event.meetup.id, user_id: user.id, is_owner: false)
      end
    end

    def remove_attendee(event, user)
      Attendee.where(event_id: event.id, user_id: user.id).take.delete
    end

    def set_admin_event
      @admin_event = Event.find(params[:id])
    end

    def set_admin_meetup
      @admin_meetup = Meetup.find(params[:meetup_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_event_params
      params[:event].permit(:subject, :content, :date, :place, :price)
    end

    
end
