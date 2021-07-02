# frozen_string_literal: true
class CreateRegistrations < ActiveRecord::Migration[6.1]
  def change
    create_table :registrations do |t|
      t.string :name
      t.string :email
      t.string :how_heard
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
