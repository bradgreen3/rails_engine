FactoryGirl.define do
  factory :invoice_item do
    invoice 
    item 
    quantity 1
    unit_price 1
  end
end
