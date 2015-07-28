class AddUserToCustomers < ActiveRecord::Migration
  def change
    add_reference :customers, :user, index: true, foreign_key: true
  end
end
