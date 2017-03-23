# Creates the users table in the database.
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, &:timestamps
  end
end
