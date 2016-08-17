class CreateMsgdata < ActiveRecord::Migration
  def change
    create_table :msgdata do |t|
      t.integer :seq
      t.string :value

      t.timestamps null: false
    end
  end
end
