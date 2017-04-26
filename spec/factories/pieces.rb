FactoryGirl.define do
  factory :piece do
    color 'white'
    active true
    x_position 1
    y_position 1
    type ''
    association :game
  end

  factory :queen do
    color 'white'
    active true
    x_position 4
    y_position 4
    type 'Queen'
    association :game
  end
end
