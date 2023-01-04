class CreateInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :invites do |t|
      t.references :event, null: false, foreign_key: true
      t.references :attendee, null: false, foreign_key: {to_table: :users}
      t.boolean    :accepted, default: nil

      t.timestamps
    end
  end
end
