class CheckoutController < ApplicationController
  def create
    @total = params[:total].to_d
    @event = Event.find(params[:event])
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total*100).to_i,
            product_data: {
            name: 'Rails Stripe Checkout',
            },
          },
          quantity: 1
        },
      ],
      mode: 'payment',
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
    # Stocker l'ID de l'événement dans la session
    session[:event_id] = @event.id

    redirect_to @session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    stripe_id = @payment_intent.id
    puts "$$$$$$$$$$"
    puts @payment_intent
    puts stripe_id
    puts "$$$$$$$$$$"

    # Récupérer l'ID de l'événement depuis la session
    @event = Event.find(session[:event_id])
    
    # Créer l'attendance avec l'utilisateur courant
    @attendance = Attendance.create(stripe_customer_id: stripe_id, event: @event, guest: current_user)

    # Effacer l'ID de l'événement de la session
    session.delete(:event_id)
  end

  def cancel
  end
  
end