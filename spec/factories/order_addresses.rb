FactoryBot.define do
  factory :order_address do
    post_code { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { '東京都' }
    street { '1-1' }
    building { '東京ハイツ' }
    tel { '09012345678' }

    transient do
      dummy_token { 'tok_abcdefghijk00000000000000000' }
    end

    after(:build) do |order_address, evaluator|
      order_address.token = evaluator.dummy_token
    end
  end
end
