class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :roles
      t.references :business, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
