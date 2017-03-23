# This migration adds email and name fields to the users table.
class AlterUsersAddEmailAddName < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email, :string
    add_column :users, :name, :string
  end
end
