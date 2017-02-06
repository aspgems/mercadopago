class PaymentsController < ApplicationController

  def index
    @payments = Payment.all.order(created_at: :desc)
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(token_payment_params)
    @payment.email = params[:email]
    @payment.pay!
    if @payment.errors.any?
      render 'new'
    else
      redirect_to payments_path and return
    end
  end

  def show
    @payment = Payment.find(params[:id])
  end

  private

  def payment_params
    params.require(:payment).permit(:first_name, :last_name, :number, :month, :year, :verification_value)
  end
  def token_payment_params
    params.permit(:token,:payment_method_id, :email, :amount)
  end

end
