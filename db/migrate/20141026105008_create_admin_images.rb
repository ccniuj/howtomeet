class CreateAdminImages < ActiveRecord::Migration
  def change
    create_table :admin_images do |t|

      t.timestamps
    end
  end
end
