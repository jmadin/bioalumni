class RecordsController < ApplicationController
  before_action :signed_in_user
  before_action :set_record, only: [:show, :edit, :update, :destroy]

  # GET /records
  # GET /records.json
  def index
    # @records = Record.all
    @records = Record.paginate(page: params[:page])
  end

  # GET /records/1
  # GET /records/1.json
  def show
  end

  # GET /records/new
  def new
    @record = Record.new
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(record_params)

    # @alum = Alum.find(params[:alum_id])
    # @record = @alum.records.create(record_params)

    if @record.save
      redirect_to alum_path(@record.alum), flash: {success: "Record was successfully created." }
    else
      render :new #, :alum_id => record_params[:alum_id]
    end
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to alum_path(@record.alum), flash: {success: "Record was successfully updated." } }
        format.json { render :show, status: :ok, location: @record }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record.destroy
    respond_to do |format|
      format.html { redirect_to alum_path(@record.alum), flash: {danger: "Record was successfully deleted." } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:user_id, :alum_id, :career_id, :work_link, :email, :phone, :record_notes, :position_title, :record_date, :until_date, :company_name)
    end
end
