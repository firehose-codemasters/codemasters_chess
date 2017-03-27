class User < ApplicationRecord
  has_many :games_as_white_player, class_name: 'Game', foreign_key: 'white_player_id'
  has_many :games_as_black_player, class_name: 'Game', foreign_key: 'black_player_id'
  validates :name, presence: true
  validates :email, presence: true
end
