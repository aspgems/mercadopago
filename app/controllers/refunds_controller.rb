class RefundsController < ApplicationController

  def index
    @refunds = Refund.find_by_payment_id(params[:payment_id])
  end

  def create
    @payment = Payment.find(params[:payment_id])
    @refund = @payment.refunds.build(refund_params)
    @refund.refund!
    redirect_to payment_path(@payment)
  end


  private

  def refund_params
    params.permit(:amount)
  end

end
