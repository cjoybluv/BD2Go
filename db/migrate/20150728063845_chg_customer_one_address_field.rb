class ChgCustomerOneAddressField < ActiveRecord::Migration
  def change
    remove_column :customers, :street
    remove_column :customers, :city
    remove_column :customers, :st
    remove_column :customers, :zip
    add_column :customers, :address, :string
  end
end
