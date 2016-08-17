class CreateGrps < ActiveRecord::Migration
  def change
    create_table :grps do |t|
      t.string :comp
      t.string :port
      t.string :trcode

      t.timestamps null: false
    end
  end
end
