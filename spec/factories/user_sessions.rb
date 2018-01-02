FactoryBot.define do
  factory :user_session do
    token 'token'
    expires DateTime.now
    association :user, factory: :user
  end
end
