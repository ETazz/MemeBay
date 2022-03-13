FactoryBot.define do
  factory :listing do
    title { "MyString" }
    string { "MyString" }
    price { 1 }
    solds { false }
    description { "MyText" }
    memeber { nil }
    category { nil }
  end
end
