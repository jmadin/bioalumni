class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  WillPaginate.per_page = 15
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) or current_user.admin?
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
end
