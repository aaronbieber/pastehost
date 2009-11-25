class AddPrivateAndAddr < ActiveRecord::Migration
  def self.up
    add_column :pastes, :private, :boolean, { :default => false,  :null => false }
    add_column :pastes, :ip,      :string,  { :limit => 15,       :null => true }
  end

  def self.down
    remove_column :pastes, :private
    remove_column :pastes, :ip
  end
end
