class StaticPagesController < ApplicationController
  before_action :signed_in_user, only: [:about]

  def home


    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string')
    data_table.new_column('number')

    Career.all.each do |i|
      data_table.add_row([i.career_name, Record.where("career_id = ?", i.id).size])
    end

    option = { width: 400, height: 300, :title => 'Graduate careers' }
    @chart_careers = GoogleVisualr::Interactive::PieChart.new(data_table, option)


    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Year')
    data_table.new_column('number', 'PhD Biol')
    data_table.new_column('number', 'PhD BBE')

    temp = Degree.where('graduation_year IS NOT NULL').map { |e| e.graduation_year.year }

    (temp.min..temp.max).each do |i|
      data_table.add_row([i.to_s, Degree.where("degree_type_id = ? AND strftime('%Y', graduation_year) = ?", 1, i.to_s).size, Degree.where("degree_type_id = ? AND strftime('%Y', graduation_year) = ?", 5, i.to_s).size])
    end

    option = { width: 400, height: 300, :title => 'Biology PhDs' }
    @chart_phds = GoogleVisualr::Interactive::ColumnChart.new(data_table, option)
  end

  def help
  end

  def about
  end

  def contact
  end
end
