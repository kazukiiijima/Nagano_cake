class HomesController < ApplicationController

	def top
		@genres = Genre.all
		@items = Item.all.order(created_at: :desc)
	end

	def about
		about_path
	end
	
end
