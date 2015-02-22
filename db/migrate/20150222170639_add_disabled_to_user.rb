class AddDisabledToUser < ActiveRecord::Migration
  def change
    add_column :users, :disable, :boolean
  end
end
