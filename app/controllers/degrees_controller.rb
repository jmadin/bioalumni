class DegreesController < ApplicationController
  before_action :signed_in_user
  before_action :set_degree, only: [:show, :edit, :update, :destroy]

  # GET /degrees
  # GET /degrees.json
  def index
    @degrees = Degree.all
  end

  # GET /degrees/1
  # GET /degrees/1.json
  def show
  end

  # GET /degrees/new
  def new
    @degree = Degree.new
  end

  # GET /degrees/1/edit
  def edit
  end

  # POST /degrees
  # POST /degrees.json
  def create
    @degree = Degree.new(degree_params)

    if @degree.save

      user_ids =  params[:degree][:users_attributes]

      if not user_ids.nil?
        user_ids.keys().each do |k|
          user = User.find(user_ids[k]["id"])
          @degree.users << user if user_ids[k]["_destroy"] != "1" and not @degree.users.include? user
        end
      end

      if @degree.update(degree_params)
        redirect_to alum_path(@degree.alum), flash: {success: "Degree was successfully created." }
      else
        render :edit
      end
    else
      render :new
    end

    # @alum = Alum.find(params[:alum_id])
    # @degree = @alum.degrees.create(degree_params)

  end

  # PATCH/PUT /degrees/1
  # PATCH/PUT /degrees/1.json
  def update

    @degree = Degree.find(params[:id])
    user_ids =  params[:degree][:users_attributes]

    @degree.users.delete_all()

    if not user_ids.nil?
      user_ids.keys().each do |k|
        user = User.find(user_ids[k]["id"])
        @degree.users << user if user_ids[k]["_destroy"] != "1" and not @degree.users.include? user
      end
    end


    respond_to do |format|
      if @degree.update(degree_params)
        format.html { redirect_to alum_path(@degree.alum), flash: {success: "Degree was successfully updated." } }
        format.json { render :show, status: :ok, location: @degree }
      else
        format.html { render :edit }
        format.json { render json: @degree.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /degrees/1
  # DELETE /degrees/1.json
  def destroy
    @degree.destroy
    respond_to do |format|
      format.html { redirect_to alum_path(@degree.alum), flash: {danger: "Degree was successfully deleted." } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_degree
      @degree = Degree.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def degree_params
      params.require(:degree).permit(:alum_id, :degree_type_id, :graduation_year, :thesis_title, :degree_notes, :users_attributes)
    end
end
