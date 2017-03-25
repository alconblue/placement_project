class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.references :student, foreign_key: true
      t.references :schedule, foreign_key: true
      t.boolean :accepted

      t.timestamps
    end
  end
end
