class Admin::MeetupsController < ApplicationController
  before_action :set_admin_meetup, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /admin/meetups
  # GET /admin/meetups.json
  def index
    @admin_meetups = Meetup.all
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
        add_meetup_member(@admin_meetup, current_user)

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

  private
    # Use callbacks to share common setup or constraints between actions.

    def add_meetup_member(meetup, user)
      MeetupMember.create(meetup_id: meetup.id, user_id: user.id, is_owner: true)
    end

    def set_admin_meetup
      @admin_meetup = Meetup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_meetup_params
      params[:meetup].permit(:title, :subtitle, :category_id, :description, :location, :day, :called, :file)
    end
end
