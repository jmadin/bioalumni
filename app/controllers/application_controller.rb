class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  WillPaginate.per_page = 15

  before_filter :set_last_seen_at, if: proc { |p| signed_in? && (session[:last_seen_at] == nil || session[:last_seen_at] < 15.minutes.ago) }
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) or current_user.admin?
  end

  def admin_user
    if not current_user.admin?
      flash[:danger] = "Contact <a href='mailto:joshua.madin@mq.edu.au' >joshua.madin@mq.edu.au</a> to make this change.".html_safe 
      redirect_back_or request.referer
    end
  end

  def export_alumni  

    @all = Alum.find_by_sql("
      SELECT *, degrees.id as deg_id
      FROM alums 
      LEFT OUTER JOIN degrees ON alums.id = degrees.alum_id
      LEFT OUTER JOIN degree_types ON degrees.degree_type_id = degree_types.id
    ") 

    csv_string = CSV.generate do |csv|   
      csv << [
        "id", "first_name", "middle_name", "last_name", "sex", "dob", "mq_id", "linked_in", "twitter", "facebook", "degree_type_name", "graduation_year", "supervisor/s"]

      @all.each do |i|
        sups = DegreesUser.where("degree_id IS ?", i.deg_id).map(&:user_id)
        sups = User.where("id IN (?)", sups).map { |s| "#{s.name} #{s.surname}" }.join(';')
        puts sups

        if i.graduation_year.present?
          i.graduation_year = Date.parse(i.graduation_year).strftime("%Y")
        end

        csv << [
          i.id, i.first_name, i.middle_name, i.last_name, i.sex, i.dob, i.mq_id, i.linked_in, i.twitter, i.facebook, i.degree_type_name, i.graduation_year, sups]
        end 
    end 
    send_data csv_string, 
        :type => 'text/csv; charset=iso-8859-1; header=present', :stream => true,
        :disposition => "attachment; filename=alumni_#{Date.today.strftime('%Y%m%d')}.csv" 
  end  

  private

    def set_last_seen_at
      current_user.update_attribute(:last_seen_at, Time.now)
      session[:last_seen_at] = Time.now
    end

end
