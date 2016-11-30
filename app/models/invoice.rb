class Invoice < ApplicationRecord
	default_scope { order('id ASC')}

	belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
end
