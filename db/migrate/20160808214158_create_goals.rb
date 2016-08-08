class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false, index: true
      t.string :title, null: false
      t.text :details, null: false
      t.boolean :goal_private, null: false, default: false
      t.boolean :completed, null: false, default: false
      t.timestamps null: false
    end
  end
end
