class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :email
      t.references :user, foreign_key: true
      t.text :description
      t.string :poc_name
      t.string :poc_email
      t.string :poc_phone

      t.timestamps
    end
  end
end
