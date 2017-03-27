FactoryGirl.define do
  factory :game do
    name 'Chess'
    result 'in_progress'
    association :white_player, factory: :user
    association :black_player, factory: :user
  end
end
