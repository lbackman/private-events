class AddIndexOnAttendeeIdAndEventId < ActiveRecord::Migration[7.0]
  def change
    add_index(:invites, [:event_id, :attendee_id], unique: true)
  end
end
