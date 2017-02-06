class CreateRefunds < ActiveRecord::Migration
  def change
    create_table :refunds do |t|
      t.references :payment
      t.decimal :amount, precision: 15, scale: 3
      t.string :remote_code
      t.timestamps null: false
    end
  end
end
