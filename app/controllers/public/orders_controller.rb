class Public::OrdersController < ApplicationController

	before_action :authenticate_customer!

	def new
		@order = Order.new
		@customer = current_customer
		@address = Address.new
		@addresses = current_customer.addresses
	end

	def confirm
		@cart_items = current_customer.cart_items
		@order = Order.new(order_params)
		@order.customer_id = current_customer.id
		case params[:order][:select_address]
			when "self"
				@order.address = current_customer.address
				@order.postal_code = current_customer.postal_code
				@order.name = current_customer.full_name
			when "registered"
				@registered_address = Address.find(params[:order][:address_index])
				@order.address = @registered_address.address
				@order.postal_code = @registered_address.postal_code
				@order.name = @registered_address.name
			when "new_address"
				@order.address = params[:order][:address]
				@order.postal_code = params[:order][:postal_code]
				@order.name = params[:order][:name]
		end
		session[:next] = @order
	end

	def create
		@order = Order.new(session[:next])
		@order.save
		@cart_items = CartItem.where(customer_id: current_customer.id )
		@cart_items.each do |cart_item|
			@order_details = OrderDetail.new({
				item_id: cart_item.item_id,
				price: cart_item.item.price,
				amount: cart_item.amount,
				order_id: @order.id
				})
			@order_details.save
		end
		current_customer.cart_items.delete_all
		redirect_to  orders_complete_path
	end

	def complete
	end

	def index
		@orders = current_customer.orders
	end

	def show
		@order = Order.find(params[:id])
	end

	private

	def order_params
		params.require(:order).permit(:address, :postal_code, :name, :payment_method, :customer_id)
	end
end
