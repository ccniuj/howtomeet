class CreateMeetupMembers < ActiveRecord::Migration
  def change
    create_table :meetup_members do |t|
      t.integer :meetup_id
      t.integer :user_id
      t.boolean :is_owner

      t.timestamps
    end
  end
end
