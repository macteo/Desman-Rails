class AddValueToEvents < ActiveRecord::Migration
  def change
    add_column :events, :value, :string
  end
end
