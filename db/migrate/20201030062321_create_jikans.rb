class CreateJikans < ActiveRecord::Migration[6.0]
  def change
    create_table :jikans do |t|
      t.integer :start_time, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
