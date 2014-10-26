class CreateAdminNotes < ActiveRecord::Migration
  def change
    create_table :admin_notes do |t|

      t.timestamps
    end
  end
end
