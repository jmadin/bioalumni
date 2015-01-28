class AlumsController < ApplicationController
  before_action :signed_in_user
  before_action :set_alum, only: [:show, :edit, :update, :destroy]

  # GET /alums
  # GET /alums.json
  def index
    # @alums = Alum.all
    @alums = Alum.paginate(page: params[:page], per_page: 25).search(params[:search])

    if params[:tag]
      @alums = @alums.tagged_with(params[:tag])
    end
  end

  # GET /alums/1
  # GET /alums/1.json
  def show
  end

  # GET /alums/new
  def new
    @alum = Alum.new
  end

  # GET /alums/1/edit
  def edit
  end

  # POST /alums
  # POST /alums.json
  def create
    @alum = Alum.new(alum_params)

    respond_to do |format|
      if @alum.save
        format.html { redirect_to @alum, flash: {danger: "Alum was successfully created." } }
        format.json { render :show, status: :created, location: @alum }
      else
        format.html { render :new }
        format.json { render json: @alum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alums/1
  # PATCH/PUT /alums/1.json
  def update
    respond_to do |format|
      if @alum.update(alum_params)
        format.html { redirect_to @alum, flash: {danger: "Alum was successfully updated." } }
        format.json { render :show, status: :ok, location: @alum }
      else
        format.html { render :edit }
        format.json { render json: @alum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alums/1
  # DELETE /alums/1.json
  def destroy
    @alum.destroy
    respond_to do |format|
      format.html { redirect_to alums_url, flash: {danger: "Alum was successfully deleted." } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alum
      @alum = Alum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alum_params
      params.require(:alum).permit(:user_id, :first_name, :middle_name, :last_name, :sex, :dob, :mq_id, :tag_list, :alum_notes)
    end
end
