FactoryBot.define do
  factory :micropost do
    message 'test'
    association :user, factory: :user
  end
end
