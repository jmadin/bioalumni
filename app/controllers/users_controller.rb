class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]

  helper_method :sort_column, :sort_direction

  def index
    @users = User.search(params[:search]).sort_by { |x| x.degrees.size }.reverse
    # @users = User.order(:name).paginate(page: params[:page])


    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
    end
  end

  def show
    @user = User.find(params[:id])

    @alums = Alum.where(:id => @user.degrees.map(&:alum_id)).paginate(page: params[:page], per_page: 25)

    if @alums.present? && @user.degrees.where('graduation_year IS NOT NULL').present?
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Year')
      data_table.new_column('number', 'Graduates')

      temp = @user.degrees.where('graduation_year IS NOT NULL').map { |e| e.graduation_year.year }
      puts "HERE: #{temp}"

      (temp.min..temp.max).each do |i|
        data_table.add_row([i.to_s, @user.degrees.where("strftime('%Y', graduation_year) = ?", i.to_s).size])
      end

      option = { width: 400, height: 250, :title => 'Graduates', :legend => 'none' }
      @chart_phds = GoogleVisualr::Interactive::ColumnChart.new(data_table, option)
    end


  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if current_user.admin?
      @user.code = "e8b"
      @user.password = "sunflower9"
      @user.password_confirmation = "sunflower9"
      @user.email = "#{@user.name.downcase}.#{@user.surname.downcase}@mq.edu.au"
      if @user.save
        flash[:success] = "Supervisor added"
        redirect_to @user
      else
        render 'new'
      end
    else
      if @user.code == "e8b"
        if @user.save
          sign_in @user
          flash[:success] = "Welcome to Biolumni"
          redirect_to @user
        else
          render 'new'
        end
      else
        flash.now[:danger] = "You need the code from the HoD."
        render 'new'
      end
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:danger] = "User destroyed."
    redirect_to users_url
  end


  private

    def user_params
      params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :code, degrees_attributes: [:id, :_destroy])
    end

    def sort_column
      Photo.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    # Before filters
  end
