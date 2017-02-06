class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :first_name
      t.string :last_name
      t.string :number
      t.string :month
      t.integer :year
      t.string :verification_value

      t.timestamps null: false
    end
  end
end
