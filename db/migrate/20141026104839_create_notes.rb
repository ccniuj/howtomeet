class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :event_id
      t.string :file_id
      t.string :view_link
      t.string :edit_link
      
      t.timestamps
    end
  end
end
