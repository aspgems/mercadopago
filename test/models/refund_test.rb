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

require "test_helper"

class RefundTest < ActiveSupport::TestCase
  def refund
    @refund ||= Refund.new
  end

  def test_valid
    assert refund.valid?
  end
end
