FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 7)
    nickname              {"エキスパ太郎"}
    email                 {Faker::Internet.free_email}
    password              {password}
    password_confirmation {password}
    first_name            {Faker::Name.first_name}
    first_name_kana       {"シンタロウ"}
    family_name           {Faker::Name.family_name}
    family_name_kana      {"ヤマダ"}
    birth_date            {{1=>1990, 2=>1, 3=>1}}
  end
end