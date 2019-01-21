class CreateDecks < ActiveRecord::Migration[5.2]
  def change
    create_table :decks do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :qr_code, null: false

      t.timestamps
    end
  end
end
