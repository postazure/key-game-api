class Deck < ActiveRecord::Base
  belongs_to :added_by, class_name: 'User', foreign_key: 'added_by'
  has_many :games

  validates_uniqueness_of :uuid, :qr_code, :name

  scope :id_from_uuid, ->(uuid) {self.select(:id).find_by(uuid: uuid).id}
end