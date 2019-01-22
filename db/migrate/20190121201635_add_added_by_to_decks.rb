class AddAddedByToDecks < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :added_by, :bigint
  end
end
