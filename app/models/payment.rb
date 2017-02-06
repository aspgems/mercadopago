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

class Payment < ActiveRecord::Base

  has_many :refunds, inverse_of: :payment


  def  pay!
    save
    # ActiveMerchant accepts all amounts as Integer values in cents
    response = gateway.purchase((self.amount.to_f * 100).to_i, {card_token: self.token, brand: self.payment_method_id}, {order_id: self.id, email: self.email})

    if response.success?
      card_params = response.params['card']

      puts "Successfully charged $#{self.amount} to the credit card ********#{card_params['last_four_digits']}"

      self.remote_code = response.params['id']
      self.first_name =  card_params['cardholder']['name']
      self.number =  "********#{card_params['last_four_digits']}"
      self.month =  card_params['expiration_month']
      self.year =  card_params['expiration_year']
      self.data = response.params.to_json
      save
    else
      self.errors.add(:base, response.params['message'])
      self.message = response.params['message']
      self.data = response.params.to_json
    end

  end



  def test
    # Use the TrustCommerce test servers
    ActiveMerchant::Billing::Base.mode = :test

    gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
        :login => 'TestMerchant',
        :password => 'password')

    # ActiveMerchant accepts all amounts as Integer values in cents
    amount = 1000  # $10.00

    # The card verification value is also known as CVV2, CVC2, or CID
    credit_card = ActiveMerchant::Billing::CreditCard.new(
        :first_name         => 'Bob',
        :last_name          => 'Bobsen',
        :number             => '4242424242424242',
        :month              => '8',
        :year               => Time.now.year+1,
        :verification_value => '000')


    # Validating the card automatically detects the card type
    if credit_card.validate.empty?
      # Capture $10 from the credit card
      response = gateway.purchase(amount, credit_card)

      if response.success?
        puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
      else
        raise StandardError, response.message
      end
    end
  end

  def real_amount
    amount - refunds.done.map(&:amount).sum
  end

  def gateway

    ActiveMerchant::Billing::Base.mode = :test

    @gateway ||= ActiveMerchant::Billing::MercadopagoGateway.new(
        client_id: Chamber.env.mercadopago.client_id,
        client_secret: Chamber.env.mercadopago.client_secret,
        public_key: Chamber.env.mercadopago.public_key,
        token: Chamber.env.mercadopago.access_token)

  end
end
