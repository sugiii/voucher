class CreateTestcases < ActiveRecord::Migration
  def change
    create_table :testcases do |t|
      t.string :name
      t.string :desc
      t.string :exprlt
      t.string :rlt
      t.date :try

      t.timestamps null: false
    end
  end
end
