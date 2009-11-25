class AddDates < ActiveRecord::Migration
  def self.up
    add_column :pastes, :created_at, :datetime, :null => false
    add_column :pastes, :modified_at, :datetime, :null => true
  end

  def self.down
    remove_column :pastes, :created_at
    remove_column :pastes, :modified_at
  end
end
