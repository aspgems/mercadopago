class AddMessageAndDataToRefund < ActiveRecord::Migration
  def change
    add_column :refunds, :message, :string
    add_column :refunds, :data, :text
  end
end
