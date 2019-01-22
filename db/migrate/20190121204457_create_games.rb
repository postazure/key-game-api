class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.belongs_to :user, null: false

      t.string :deck_uuid, null: false
      t.string :opponent_deck_uuid, null: false

      t.boolean :win, null: false
      t.string :notes

      t.timestamps
    end
  end
end
