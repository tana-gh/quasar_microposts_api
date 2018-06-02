FactoryBot.define do
  factory :micropost do
    message 'test'
    association :user, factory: :user
  end
  
  factory :microposts, class: Micropost do
    sequence(:message) { |n| "test_#{n}" }
    sequence(:user)    { User.first || FactoryBot.create(:users) }
  end
end
