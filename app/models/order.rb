class Order < ApplicationRecord

has_many :order_details
belongs_to :customer
enum payment_method: { クレジットカード: 1, 銀行振込: 2 }

def full_address
	"#{self.address} #{self.postal_code} #{self.name}"
end



end
