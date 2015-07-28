class RenameCustomerLatlngToLnglat < ActiveRecord::Migration
  def change
    rename_column :customers, :latlng, :lnglat
  end
end
