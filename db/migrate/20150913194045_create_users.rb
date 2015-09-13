class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :index
      t.string :create
      t.string :delete
      t.string :update

      t.timestamps null: false
    end
  end
end
