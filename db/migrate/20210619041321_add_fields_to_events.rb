# frozen_string_literal: true
class AddFieldsToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :starts_at, :datetime
    add_column :events, :description, :text
  end
end
