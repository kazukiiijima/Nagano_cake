class Public::ItemsController < ApplicationController

	def index
		@genres = Genre.all

		if params[:genre].blank?
			@genre_name = '商品'
		else
			@genre_name = Genre.find(params[:genre]).name
		end

		if params[:genre].blank?
			@items = Item.all.page(params[:page]).per(10)
		else
			@items = Item.where(genre_id: params[:genre]).page(params[:page]).per(10)
		end

		if params[:genre].blank?
			@items_count = Item.count
		else
			@items_count = @items.count
		end
	end

	def show
		@genres = Genre.all
		@item = Item.find(params[:id])
		@cart_item = CartItem.new
	end

end