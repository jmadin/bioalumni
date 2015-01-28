class DegreeTypesController < ApplicationController
  before_action :signed_in_user
  before_action :set_degree_type, only: [:show, :edit, :update, :destroy]

  # GET /degree_types
  # GET /degree_types.json
  def index
    @degree_types = DegreeType.all
  end

  # GET /degree_types/1
  # GET /degree_types/1.json
  def show
  end

  # GET /degree_types/new
  def new
    @degree_type = DegreeType.new
  end

  # GET /degree_types/1/edit
  def edit
  end

  # POST /degree_types
  # POST /degree_types.json
  def create
    @degree_type = DegreeType.new(degree_type_params)

    respond_to do |format|
      if @degree_type.save
        format.html { redirect_to @degree_type, flash: {danger: "Degree was successfully created." } }
        format.json { render :show, status: :created, location: @degree_type }
      else
        format.html { render :new }
        format.json { render json: @degree_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /degree_types/1
  # PATCH/PUT /degree_types/1.json
  def update
    respond_to do |format|
      if @degree_type.update(degree_type_params)
        format.html { redirect_to @degree_type, flash: {danger: "Degree was successfully updated." } }
        format.json { render :show, status: :ok, location: @degree_type }
      else
        format.html { render :edit }
        format.json { render json: @degree_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /degree_types/1
  # DELETE /degree_types/1.json
  def destroy
    @degree_type.destroy
    respond_to do |format|
      format.html { redirect_to degree_types_url, flash: {danger: "Degree was successfully deleted." } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_degree_type
      @degree_type = DegreeType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def degree_type_params
      params.require(:degree_type).permit(:degree_type_name, :degree_type_notes)
    end
end
