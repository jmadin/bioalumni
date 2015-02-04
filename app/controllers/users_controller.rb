class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]

  helper_method :sort_column, :sort_direction

  def index
    @users = User.all.sort_by { |x| x.degrees.size }.reverse
  end

  def show
    @user = User.find(params[:id])

    @alums = Alum.where(:id => @user.degrees.map(&:alum_id)).paginate(page: params[:page], per_page: 25)

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :code, degrees_attributes: [:id, :_destroy])
    end

    def sort_column
      Photo.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    # Before filters
  end
