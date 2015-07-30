class AddAstroSignToUsers < ActiveRecord::Migration
  def change
     add_column :users, :astro_sign, :string
  end
end
