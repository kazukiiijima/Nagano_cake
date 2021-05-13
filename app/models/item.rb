class Item < ApplicationRecord

	belongs_to :genre
	has_many :cart_items, dependent: :destroy
	has_many :order_details
	attachment :image

	enum is_active: { 販売停止中: false, 販売中: true }



end
