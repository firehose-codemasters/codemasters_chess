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
    x_position 1
    y_position 1
    type 'Queen'
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

  factory :pawn do
    color 'white'
    active true
    x_position 1
    y_position 2
    type 'Pawn'
    association :game
  end
end
