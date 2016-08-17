class CreateMsgforms < ActiveRecord::Migration
  def change
    create_table :msgforms do |t|
      t.integer :seq
      t.string :name
      t.integer :pos
      t.integer :len
      t.string :desc

      t.timestamps null: false
    end
  end
end
