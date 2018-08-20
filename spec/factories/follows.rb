FactoryBot.define do
  factory :follow do
    association :followee, factory: :users
    association :follower, factory: :users
  end

  factory :follows, class: Follow do
    sequence(:followee) { User.first || FactoryBot.create(:users) }
    association :follower, factory: :users
  end
end
