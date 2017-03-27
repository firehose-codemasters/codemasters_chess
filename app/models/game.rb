class Game < ApplicationRecord
  belongs_to :white_player, class_name: 'User'
  belongs_to :black_player, class_name: 'User'
  validates :name, presence: true
  validates :result, inclusion: {
    in: %w(in_progress white_win black_win draw),
    message: '%{value} is not a valid result'
  }
  validates :white_player, presence: true
  validates :black_player, presence: true
end
