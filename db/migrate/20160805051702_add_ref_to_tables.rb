class AddRefToTables < ActiveRecord::Migration
  def change
     add_reference :testcases, :grp, index: true, foreign_key: true
     add_reference :msgforms, :grp, index: true, foreign_key: true
     add_reference :msgdata, :testcase, index: true, foreign_key: true
  end
end
