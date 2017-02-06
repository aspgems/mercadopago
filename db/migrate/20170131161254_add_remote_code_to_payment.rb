class AddRemoteCodeToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :remote_code, :string
  end
end
