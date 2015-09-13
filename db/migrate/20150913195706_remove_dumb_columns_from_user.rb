class RemoveDumbColumnsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :index
    remove_column :users, :create
    remove_column :users, :delete
    remove_column :users, :update
  end
end
