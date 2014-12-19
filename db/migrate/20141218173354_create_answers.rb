class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :word

      t.timestamps
    end
  end
end
