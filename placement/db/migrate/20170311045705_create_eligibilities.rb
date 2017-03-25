class CreateEligibilities < ActiveRecord::Migration[5.0]
  def change
    create_table :eligibilities do |t|
      t.references :schedule, foreign_key: true
      t.string :branch
      t.decimal :cgpa_min, :precision=>8, :scale=>2
      t.decimal :cgpa_max, :precision=>8, :scale=>2
      t.decimal :package_min, :precision=>8, :scale=>2
      t.decimal :package_max, :precision=>8, :scale=>2
      t.text :comments
      t.text :skills

      t.timestamps
    end
  end
end
