FactoryGirl.define do
  factory :customer do
    first_name "Nick"
    last_name  "D"
  end

  factory :merchant do
    name "Macy's"
  end

  factory :item do
    name        "hammer"
    description "it's time"
    unit_price  4000
    merchant
  end

  factory :invoice do
    merchant
    customer
    status "completed"
  end

  factory :invoice_item do
    item
    invoice
    quantity 2
    unit_price 4000
  end

  factory :transaction do
    invoice
    credit_card_number "1234567890123456"
    credit_card_expiration_date "9/2/2019"
    result "pending"
  end
end
