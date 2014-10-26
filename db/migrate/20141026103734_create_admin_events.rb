class CreateAdminEvents < ActiveRecord::Migration
  def change
    create_table :admin_events do |t|

      t.timestamps
    end
  end
end
