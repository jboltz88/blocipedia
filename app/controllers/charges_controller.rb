class ChargesController < ApplicationController
  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    if charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Blocipedia - #{current_user.email}",
      currency: 'usd'
    )
      current_user.premium!
      flash[:notice] = "Congratulations, #{current_user.email}! You're account has been upgraded, and you are now free to create private Wikis."
      redirect_to edit_user_registration_path
    end

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia - #{current_user.email}",
      amount: Amount.default
    }
  end
end
