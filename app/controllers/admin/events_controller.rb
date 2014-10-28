class Admin::EventsController < ApplicationController
  before_action :set_admin_event, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_meetup
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

  private
    # Use callbacks to share common setup or constraints between actions.

    def add_attendee(event, user)
      Attendee.create(event_id: event.id, user_id: user.id)
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