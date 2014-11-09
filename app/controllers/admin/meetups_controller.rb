class Admin::MeetupsController < ApplicationController
  before_action :set_admin_meetup, only: [:show, :edit, :update, :destroy, :add, :remove]
  before_action :authenticate_user!
  before_action :check_authority, only: [:edit, :update, :delete]

  # GET /admin/meetups
  # GET /admin/meetups.json
  def index
    @admin_meetups_owner = current_user.meetups.map{ |anchor|
      anchor if anchor.is_owned?(current_user) }.compact
    @owner_counts = @admin_meetups_owner.map(&:users).map(&:count)

    @admin_meetups_member = current_user.meetups.map{ |anchor|
      anchor unless anchor.is_owned?(current_user) }.compact
    @member_counts = @admin_meetups_member.map(&:users).map(&:count)
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
        @admin_meetup.create_member(current_user)
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
    unless @admin_meetup.is_member?(current_user)
      @admin_meetup.add_member(current_user)
      flash['notice']="成功加入此聚會"
    end
    redirect_to meetup_path(@admin_meetup)
  end

  def remove
    @admin_meetup.remove_member(current_user)
    flash['notice']="成功退出此聚會"
    redirect_to meetup_path(@admin_meetup)
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def check_authority
      unless @admin_meetup.is_owned?(current_user)||current_user.is_admin == true
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
