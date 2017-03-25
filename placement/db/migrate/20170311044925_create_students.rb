class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.decimal :cgpa, :precision=>8, :scale=>2
      t.string :branch
      t.string :roll_number
      t.string :mobile_number
      t.references :user, foreign_key: true
      t.string :gender

      t.timestamps
    end
  end
end
