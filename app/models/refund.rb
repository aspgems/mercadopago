# == Schema Information
#
# Table name: refunds
#
#  id          :integer          not null, primary key
#  payment_id  :integer
#  amount      :decimal(15, 3)
#  remote_code :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  message     :string(255)
#  data        :text(65535)
#
# Indexes
#
#  fk_refunds_payment_id  (payment_id)
#

class Refund < ActiveRecord::Base

  belongs_to :payment, inverse_of: :refunds

  scope :done, -> {where.not(remote_code: nil)}

  def refund!

    refund_amount = (self.amount.to_f * 100).to_i if self.amount.present?
    save
    # ActiveMerchant accepts all amounts as Integer values in cents
    response = payment.gateway.refund(refund_amount, payment.remote_code,{order_id: self.id})

    if response.success?

      puts "Successfully refunded $#{self.amount} to the credit card ************#{payment.number}"
      self.remote_code = response.params['id']
      self.amount = response.params['amount']
      self.data = response.params.to_json
      save
    else
      self.errors.add(:base, response.params['message'])
      self.message = response.params['message']
      self.data = response.params.to_json
    end

  end
end
