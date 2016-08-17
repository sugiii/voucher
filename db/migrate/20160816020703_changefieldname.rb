class Changefieldname < ActiveRecord::Migration
  def change
    rename_column :testcases, :try, :trydate
  end
end
