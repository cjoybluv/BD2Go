class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :subject
      t.text   :body
      t.datetime :due_date_time
      t.boolean :completed

      t.timestamps null: false
    end
    add_reference :notes, :customer, index: true, foreign_key: true
    add_reference :notes, :user, index: true, foreign_key: true
  end
end
