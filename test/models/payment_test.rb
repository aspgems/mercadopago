# == Schema Information
#
# Table name: payments
#
#  id                 :integer          not null, primary key
#  first_name         :string(255)
#  last_name          :string(255)
#  number             :string(255)
#  month              :string(255)
#  year               :integer
#  verification_value :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  token              :string(255)
#  remote_code        :string(255)
#  amount             :decimal(15, 3)
#  currency           :string(255)
#  payment_method_id  :string(255)
#  email              :string(255)
#  message            :string(255)
#  data               :text(65535)
#

require "test_helper"

class PaymentTest < ActiveSupport::TestCase
  def payment
    @payment ||= Payment.new
  end

  def test_valid
    assert payment.valid?
  end
end
