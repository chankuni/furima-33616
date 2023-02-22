FactoryBot.define do
  factory :purchase_shipment do
    postal_code { Faker::Number.number(digits: 7).to_s.insert(3, "-") }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipality  { Faker::Lorem.sentence }
    address  { Faker::Lorem.sentence }
    building  { Faker::Lorem.sentence }
    tel { Faker::Number.number(digits: 11) }
    token {"tok_abcdefghijk00000000000000000"}
  end
end

