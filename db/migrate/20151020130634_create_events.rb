class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type, :null => false
      t.string :subtype, :null => false
      t.text :payload
      t.datetime :timestamp, :null => false
      t.string :uuid
      t.string :user, :null => false
      t.string :app, :null => false

      t.timestamps null: false
    end
  end
end
