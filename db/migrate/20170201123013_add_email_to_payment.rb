class AddEmailToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :email, :string
  end
end
