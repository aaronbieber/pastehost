class CreateBaseTables < ActiveRecord::Migration
  def self.up
		create_table :pastes do |t|
			t.column "code",	:string,	:limit => 5,	:null => false
			t.column "paste",	:text,									:null => false
		end
  end

  def self.down
		drop_table :pastes
  end
end
