class AddMessageAndDataToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :message, :string
    add_column :payments, :data, :text
  end
end
