class User < ActiveRecord::Base
  has_many :games

  validates_uniqueness_of :email
end