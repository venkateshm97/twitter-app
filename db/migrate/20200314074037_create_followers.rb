class CreateFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :followers do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :follow_to, null: false
      t.timestamps
    end
  end
end
