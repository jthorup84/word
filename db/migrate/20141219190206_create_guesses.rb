class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :member_id
      t.string :word

      t.timestamps
    end
  end
end
