class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.references :company, foreign_key: true
      t.datetime :date, :default => false
      t.boolean :visited

      t.timestamps
    end
  end
end
