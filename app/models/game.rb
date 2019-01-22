class Game < ActiveRecord::Base
  belongs_to :user

  scope :with_deck_uuid, -> { includes(:articles).where(decks: { id: deck_uuid}) }
end