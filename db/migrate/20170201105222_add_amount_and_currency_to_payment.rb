class AddAmountAndCurrencyToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :amount, :decimal, precision: 15, scale: 3
    add_column :payments, :currency, :string
  end
end
