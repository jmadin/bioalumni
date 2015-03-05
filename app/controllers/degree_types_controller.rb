class DegreeTypesController < ApplicationController
  before_action :signed_in_user
  before_action :set_degree_type, only: [:show, :edit, :update, :destroy]

  # GET /degree_types
  # GET /degree_types.json
  def index
    @degree_types = DegreeType.all

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string')
    data_table.new_column('number')

    @degree_types.each do |i|
      data_table.add_row([i.degree_type_name, Degree.where("degree_type_id = ?", i.id).size])
    end

    option = { width: 400, height: 300 }
    @chart_careers = GoogleVisualr::Interactive::PieChart.new(data_table, option)



    # if @degree_types.present?
    #   data_table = GoogleVisualr::DataTable.new
    #   data_table.new_column('string', 'Year')

    #   @degree_types.each do |dt|
    #     data_table.new_column('number', dt.degree_type_name)
    #     puts dt.degree_type_name
    #   end
    #   # data_table.new_column('number', 'BSc')
    #   # data_table.new_column('number', 'Masters')

    #   temp = Degree.where('graduation_year IS NOT NULL').map { |e| e.graduation_year.year }

    #   (temp.min..temp.max).each do |i|
    #     keep = [i.to_s]
    #     @degree_types.each do |dt|
    #       keep << Degree.where("degree_type_id = ? AND strftime('%Y', graduation_year) = ?", dt.id, i.to_s).size
    #     end

    #     data_table.add_row(keep)
    #   end

    #   option = { width: 800, height: 400, :title => 'Graduations' }
    #   @chart_phds = GoogleVisualr::Interactive::ColumnChart.new(data_table, option)
    # end

  end

  # GET /degree_types/1
  # GET /degree_types/1.json
  def show
    @degrees = @degree_type.degrees.paginate(page: params[:page])

    if @degrees.present?
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Year')
      data_table.new_column('number', @degree_type.degree_type_name)

      temp = @degree_type.degrees.where('graduation_year IS NOT NULL').map { |e| e.graduation_year.year }

      (temp.min..temp.max).each do |i|
        data_table.add_row([i.to_s, @degree_type.degrees.where("strftime('%Y', graduation_year) = ?", i.to_s).size])
        puts i.to_s
        puts @degree_type.degrees.where("strftime('%Y', graduation_year) = ?", i.to_s).inspect
        puts @degree_type.degrees.where("strftime('%Y', graduation_year) = ?", i.to_s).size
      end

      option = { width: 400, height: 300, :title => 'Graduations', :legend => 'none' }
      @chart_phds = GoogleVisualr::Interactive::ColumnChart.new(data_table, option)
    end

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

    begin
      @degree_type.destroy
      flash[:success] = "Degree type was successfully deleted."
    rescue ActiveRecord::DeleteRestrictionError => e
      @degree_type.errors.add(:base, e)
      flash[:danger] = "Degree type could not be deleted. Delete alumni degrees with this degree type and try again."
    end
    redirect_to degree_types_url

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
