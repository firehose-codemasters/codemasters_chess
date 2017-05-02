FactoryGirl.define do
  factory :piece do
    color 'white'
    active true
    x_position 1
    y_position 1
    type ''
    association :game
  end

  factory :king do
    color 'white'
    active true
    x_position 4
    y_position 4
    type 'King'
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

  factory :bishop do
    color 'black'
    active true
    x_position 5
    y_position 5
    type 'Bishop'
    association :game
  end

  factory :rook do
    color 'white'
    active true
    x_position 1
    y_position 3
    type 'Rook'
    association :game
  end

  factory :knight do
    color 'white'
    active true
    x_position 4
    y_position 4
    type 'Knight'
    association :game
  end
end
