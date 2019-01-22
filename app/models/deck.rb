class Deck < ActiveRecord::Base
  self.primary_key = :uuid

  belongs_to :added_by, class_name: 'User', foreign_key: 'added_by'
  has_many :games

  validates_uniqueness_of :uuid, :qr_code, :name
end