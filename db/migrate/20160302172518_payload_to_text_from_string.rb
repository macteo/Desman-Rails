class PayloadToTextFromString < ActiveRecord::Migration
  def change
    change_column :events, :payload, :text
  end
end
