class Deck < ActiveRecord::Base
  belongs_to :added_by, class_name: 'User', foreign_key: 'added_by'
  has_many :games
end