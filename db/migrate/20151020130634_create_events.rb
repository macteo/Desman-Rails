class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.string :payload
      t.datetime :timestamp
      t.string :uuid
      t.string :user
      t.string :app

      t.timestamps null: false
    end
  end
end
