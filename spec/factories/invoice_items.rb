FactoryGirl.define do
  factory :invoice_item do
    invoice nil
    item nil
    quantity 1
    unit_price 1
  end
end
