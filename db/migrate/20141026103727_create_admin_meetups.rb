class CreateAdminMeetups < ActiveRecord::Migration
  def change
    create_table :admin_meetups do |t|

      t.timestamps
    end
  end
end
