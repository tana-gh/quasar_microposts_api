FactoryBot.define do
  factory :micropost do
    message 'test'
    association :user, factory: :user
  end
  
  factory :microposts, class: Micropost do
    sequence(:message) { |n| "test_#{n}" }
    user { User.first || association(:user, factory: :user) }
  end
end
