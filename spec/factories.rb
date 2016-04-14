FactoryGirl.define do
  factory :customer do
    first_name "Nick"
    last_name  "D"
  end

  factory :merchant do
    name "Macy's"
    created_at "Tue, 27 Mar 2012 14:53:59 UTC +00:00"
    updated_at "Tue, 27 Mar 2012 14:53:59 UTC +00:00"
  end

  factory :item do
    name        "hammer"
    description "it's time"
    unit_price  4000
    association :merchant
  end

  factory :invoice do
    association :merchant
    association :customer
    status "completed"
  end

  factory :invoice_item do
    association :item
    association :invoice
    quantity 2
    unit_price 4000
  end

  factory :transaction do
    association :invoice
    credit_card_number "1234567890123456"
    credit_card_expiration_date "9/2/2019"
    result "pending"
  end
end
