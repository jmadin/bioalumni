class StaticPagesController < ApplicationController
  before_action :signed_in_user, only: [:about]

  def home


    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string')
    data_table.new_column('number')

    Career.all.each do |i|
      data_table.add_row([i.career_name, Record.where("career_id = ?", i.id).size])
    end

    option = { width: 600, height: 300, :title => 'Graduate careers' }
    @chart_careers = GoogleVisualr::Interactive::PieChart.new(data_table, option)


    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Year')
    data_table.new_column('number', 'Degrees')

    temp = Degree.where('graduation_year IS NOT NULL').map { |e| e.graduation_year.year }

    (temp.min..temp.max).each do |i|
      data_table.add_row([i.to_s, Degree.where("strftime('%Y', graduation_year) = ?", i.to_s).size])
      # data_table.add_row([i.to_s, Degree.where("degree_type_id = ? AND strftime('%Y', graduation_year) = ?", 1, i.to_s).size, Degree.where("degree_type_id = ? AND strftime('%Y', graduation_year) = ?", 5, i.to_s).size])
    end

    option = { width: 600, height: 300, :title => 'All degrees', legend: 'none' }
    @chart_phds = GoogleVisualr::Interactive::ColumnChart.new(data_table, option)


    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Year')
    data_table.new_column('number', 'Female')
    data_table.new_column('number', 'Male')

    temp = Degree.where('graduation_year IS NOT NULL').map { |e| e.graduation_year.year }

    (temp.min..temp.max).each do |i|
      data_table.add_row([i.to_s, Alum.joins(:degrees).where("strftime('%Y', graduation_year) = ?", i.to_s).where("sex = 'Female'").size, Alum.joins(:degrees).where("strftime('%Y', graduation_year) = ?", i.to_s).where("sex = 'Male'").size])
    end

    option = { width: 600, height: 300, :title => 'Degrees (male/female)' }
    @chart_sex = GoogleVisualr::Interactive::ColumnChart.new(data_table, option)


  end

  def help
  end

  def about
  end

  def contact
  end
end
