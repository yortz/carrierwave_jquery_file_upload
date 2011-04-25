class AddCheckoutToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :checkout, :boolean
  end

  def self.down
    remove_column :users, :checkout
  end
end
