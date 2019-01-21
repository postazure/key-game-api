class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.belongs_to :user, null: false
      t.belongs_to :deck, null: false

      t.boolean :win, null: false
      t.bigint :opponent_deck_id, null: false
      t.string :notes

      t.timestamps
    end
  end
end
