class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

    def index
    	@cart_items = current_customer.cart_items
  	end

  	def create
    	cart_item = CartItem.new(cart_item_params)
    	cart_item.customer_id = current_customer.id
      check = false
      current_customer.cart_items.each do |existing|
        if cart_item.item_id == existing.item_id
           existing.amount += cart_item.amount
           existing.save
           check = true
           break
        end
      end
      if check
        redirect_to cart_items_path
      else
        cart_item.save
        redirect_to cart_items_path
      end
	  end

  	def update
    	cart_item = CartItem.find(params[:id])
      cart_item.update(cart_item_params)
    	redirect_to cart_items_path
  	end

  	def destroy
  		cart_item = CartItem.find(params[:id])
    	cart_item.destroy
  		redirect_to cart_items_path(current_customer)
  	end

    def destroy_all
      CartItem.destroy_all
      redirect_to cart_items_path(current_customer)
    end

  	private

  	def cart_item_params
  		params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  	end
end
