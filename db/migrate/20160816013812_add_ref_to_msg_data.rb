class AddRefToMsgData < ActiveRecord::Migration
  def change
     add_reference :msgdata, :msgform, index: true, foreign_key: true
  end
end
