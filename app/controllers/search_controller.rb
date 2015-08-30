class SearchController < ApplicationController
  before_action :signed_in_user

	def index
		if params[:search] && params[:search] != ""
			if not params[:model_name]
				params[:model_name] = ['Alum', 'Career', 'Record', 'Degree_type', 'Degree', 'User', 'Photo']
				# params[:model_name] = ['Alum']
			end

			@result_present = false
			@store = {}

			params[:model_name].each do |m|
				@model = m.classify.constantize
				name = m.downcase + '_search'
				puts "name: "
				puts name
				puts m

				search_result = @model.search do
					fulltext params[:search]
					paginate :page => 1, :per_page => 30
				end

puts search_result.results
puts "----------------"

				if not search_result.results.blank?
					@result_present = true
				end
				
				instance_variable_set("@#{name}", search_result)

				@store[m.downcase] = search_result.results.size
			end

			# Redirect if only 1 result in 1 model
			singletons = @store.select{|key, hash| hash == 1 }
			others = @store.select{|key, hash| hash > 1 }
			models = @store.select{|key, hash| hash > 0 }

			if singletons.count == 1 and others.count == 0
				puts singletons.keys
				redirect_to eval("#{singletons.keys[0]}_path(@#{singletons.keys[0]}_search.results.first, :search => params[:search])")
			elsif models.count == 1
				redirect_to eval("#{models.keys[0]}s_path(:search => params[:search])")
			end

		else
			# @location_search = nil
		end
	end

end
