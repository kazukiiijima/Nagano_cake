class Admin::GenresController < ApplicationController

	before_action :authenticate_admin!

	def index
		@genre = Genre.new
		@genres = Genre.all
	end

	def create
		genre = Genre.new(genres_params)
		genre.save
		redirect_to admin_genres_path
	end

	def edit
		@genre = Genre.find(params[:id])
	end

	def update
		@genre = Genre.find(params[:id])
		@genre.update(genres_params)
		redirect_to admin_genres_path
	end

	private
	def genres_params
		params.require(:genre).permit(:name)
	end

end
