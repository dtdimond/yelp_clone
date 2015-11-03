class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.text :description
      t.text :picture_url
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
