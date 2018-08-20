FactoryBot.define do
  factory :user do
    name     'test'
    password 'password'
    password_confirmation 'password'
  end

  factory :users, class: User do
    sequence(:name) { |n| "test_#{n}" }
    password 'password'
    password_confirmation 'password'
  end
end
