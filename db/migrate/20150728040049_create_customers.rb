class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :st
      t.string :zip
      t.string :phone
      t.string :contact
      t.string :email
      t.string :data_sheet
      t.string :latlng
      t.string :acct_status
      t.string :acct_type

      t.timestamps null: false
    end
  end
end
