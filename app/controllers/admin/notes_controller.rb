class Admin::NotesController < ApplicationController
  before_action :set_admin_note, only: [:show, :edit, :update, :destroy]

  # GET /admin/notes
  # GET /admin/notes.json
  def index
    @admin_notes = Admin::Note.all
  end

  # GET /admin/notes/1
  # GET /admin/notes/1.json
  def show
  end

  # GET /admin/notes/new
  def new
    @admin_note = Admin::Note.new
  end

  # GET /admin/notes/1/edit
  def edit
  end

  # POST /admin/notes
  # POST /admin/notes.json
  def create
    @admin_note = Admin::Note.new(admin_note_params)

    respond_to do |format|
      if @admin_note.save
        format.html { redirect_to @admin_note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @admin_note }
      else
        format.html { render :new }
        format.json { render json: @admin_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/notes/1
  # PATCH/PUT /admin/notes/1.json
  def update
    respond_to do |format|
      if @admin_note.update(admin_note_params)
        format.html { redirect_to @admin_note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_note }
      else
        format.html { render :edit }
        format.json { render json: @admin_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/notes/1
  # DELETE /admin/notes/1.json
  def destroy
    @admin_note.destroy
    respond_to do |format|
      format.html { redirect_to admin_notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_note
      @admin_note = Admin::Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_note_params
      params[:admin_note]
    end
end
