class CreateMeetupMembers < ActiveRecord::Migration
  def change
    create_table :meetup_members do |t|

      t.timestamps
    end
  end
end
