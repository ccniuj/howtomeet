class MeetupsController < ApplicationController
  before_action :set_meetup, only: [:show, :edit, :update, :destroy]

  # GET /meetups
  # GET /meetups.json
  def index
    @meetups = Meetup.all
  end

  # GET /meetups/1
  # GET /meetups/1.json
  def show
    # @members = MeetupMember.where(meetup_id: @meetup.id).map(&:user_id).map{ |anchor| User.find(anchor) }
    @members = @meetup.users.all
    @events = @meetup.events.all
  end

  # GET /meetups/new
  def new
    @meetup = Meetup.new
  end

  # GET /meetups/1/edit
  def edit
  end

  def find
    # binding.pry
    @categories = Category.all

    category_id = params[:id].to_s
    if category_id == "all"
      @meetups = Meetup.all
    else
      @meetups = Meetup.where(category_id: Category.find(category_id).id)
    end
    @member_counts = @meetups.map(&:users).map(&:count)

  end

  # POST /meetups
  # POST /meetups.json
  def create
    @meetup = Meetup.new(meetup_params)

    respond_to do |format|
      if @meetup.save
        format.html { redirect_to @meetup, notice: 'Meetup was successfully created.' }
        format.json { render :show, status: :created, location: @meetup }
      else
        format.html { render :new }
        format.json { render json: @meetup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetups/1
  # PATCH/PUT /meetups/1.json
  def update
    respond_to do |format|
      if @meetup.update(meetup_params)
        format.html { redirect_to @meetup, notice: 'Meetup was successfully updated.' }
        format.json { render :show, status: :ok, location: @meetup }
      else
        format.html { render :edit }
        format.json { render json: @meetup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetups/1
  # DELETE /meetups/1.json
  def destroy
    @meetup.destroy
    respond_to do |format|
      format.html { redirect_to meetups_url, notice: 'Meetup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meetup
      @meetup = Meetup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meetup_params
      params[:meetup]
    end
end
