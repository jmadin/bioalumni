class StaticPagesController < ApplicationController
  before_action :signed_in_user, only: [:about]

  def home

    data_table = GoogleVisualr::DataTable.new

    data_table.new_column('string')
    data_table.new_column('number')

    Career.all.each do |i|
      data_table.add_row([i.career_name, Record.where("career_id = ?", i.id).size])
    end

    option = { width: 500, height: 300 }
    @chart = GoogleVisualr::Interactive::PieChart.new(data_table, option)


  end
  
  def help
  end

  def about
  end

  def contact
  end
end
