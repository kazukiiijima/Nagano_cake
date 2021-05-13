class Admin::OrdersController < ApplicationController

	before_action :authenticate_admin!

	def index
		case params[:order_sort]
			when "1"
				@customer = Customer.find(params[:customer_id])
   				@orders = @customer.orders.page(params[:page]).per(10)
   			else
				@orders = Order.all.page(params[:page]).per(10)
   			end
	end

	def show
		@order = Order.find(params[:id])
	end

end
