FactoryBot.define do
  factory :listing do
    title { "MyString" }
    price { 1 }
    sold { false }
    description { "MyText" }
    memeber { nil }
    category { nil }
  end
end
