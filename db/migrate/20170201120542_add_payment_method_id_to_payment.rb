class AddPaymentMethodIdToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :payment_method_id, :string, references: nil
  end
end
