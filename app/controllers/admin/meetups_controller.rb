class Admin::MeetupsController < ApplicationController
  before_action :set_admin_meetup, only: [:show, :edit, :update, :destroy, :add, :remove]
  before_action :authenticate_user!
  before_action :check_authority, only: [:edit, :update, :delete]

  # GET /admin/meetups
  # GET /admin/meetups.json
  def index
    @admin_meetups_owner = current_user.meetups.map{ |anchor|
      anchor if anchor.is_owned?(current_user) }.has_element
    @admin_meetups_member = current_user.meetups.map{ |anchor|
      anchor unless anchor.is_owned?(current_user) }.has_element
  end

  # GET /admin/meetups/1
  # GET /admin/meetups/1.json
  def show
  end

  # GET /admin/meetups/new
  def new
    @admin_meetup = Meetup.new
    @categories = Category.all
  end

  # GET /admin/meetups/1/edit
  def edit
    @categories = Category.all
  end

  # POST /admin/meetups
  # POST /admin/meetups.json
  def create
    @admin_meetup = Meetup.new(admin_meetup_params)
    @admin_meetup.cover = params[:meetup][:cover]
    # binding.pry
    respond_to do |format|
      if @admin_meetup.save
        create_meetup_member(@admin_meetup, current_user)

        format.html { redirect_to @admin_meetup, notice: '成功建立聚會' }
        format.json { render :show, status: :created, location: @admin_meetup }
      else
        format.html { render :new }
        format.json { render json: @admin_meetup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/meetups/1
  # PATCH/PUT /admin/meetups/1.json
  def update
    @admin_meetup.cover = params[:meetup][:cover]
    respond_to do |format|
      if @admin_meetup.update(admin_meetup_params)
        format.html { redirect_to @admin_meetup, notice: '成功更新聚會' }
        format.json { render :show, status: :ok, location: @admin_meetup }
      else
        format.html { render :edit }
        format.json { render json: @admin_meetup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/meetups/1
  # DELETE /admin/meetups/1.json
  def destroy
    @admin_meetup.destroy
    respond_to do |format|
      format.html { redirect_to admin_meetups_url, notice: '成功刪除聚會' }
      format.json { head :no_content }
    end
  end

  def add
    unless MeetupMember.where(meetup_id: @admin_meetup.id, user_id: current_user.id).take
      add_meetup_member(@admin_meetup, current_user)
      flash['notice']="成功加入此聚會"
    end
    redirect_to meetup_path(@admin_meetup)
  end

  def remove
    remove_meetup_member(@admin_meetup, current_user)
    flash['notice']="成功退出此聚會"
    redirect_to meetup_path(@admin_meetup)
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def create_meetup_member(meetup, user)
      MeetupMember.create(meetup_id: meetup.id, user_id: user.id, is_owner: true)
    end

    def add_meetup_member(meetup, user)
      MeetupMember.create(meetup_id: meetup.id, user_id: user.id, is_owner: false)
    end

    def remove_meetup_member(meetup, user)
      MeetupMember.where(meetup_id: meetup.id, user_id: user.id).take.delete
      meetup.events.each{ |event| Attendee.where(event_id: event.id, user_id: current_user.id).take.delete }
    end

    def check_authority
      unless @admin_meetup.is_owned?(current_user)
        redirect_to admin_meetups_path
      end
    end

    def set_admin_meetup
      @admin_meetup = Meetup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_meetup_params
      params[:meetup].permit(:title, :title_en, :subtitle, :category_id, :description, :location, :day, :called, :file)
    end
end

class Array
  def has_element
    self[0] ? self : []
  end
end