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
  end

  # GET /admin/meetups/1/edit
  def edit
  end

  # POST /admin/meetups
  # POST /admin/meetups.json
  def create
    @admin_meetup = Meetup.new(admin_meetup_params)

    respond_to do |format|
      if @admin_meetup.save
        format.html { redirect_to @admin_meetup, notice: 'Meetup was successfully created.' }
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
    respond_to do |format|
      if @admin_meetup.update(admin_meetup_params)
        format.html { redirect_to @admin_meetup, notice: 'Meetup was successfully updated.' }
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
      format.html { redirect_to admin_meetups_url, notice: 'Meetup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_meetup
      @admin_meetup = Meetup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_meetup_params
      params[:admin_meetup]
    end
end
