FactoryBot.define do
  factory :user_session do
    token 'token'
    association :user, factory: :user
  end
end
