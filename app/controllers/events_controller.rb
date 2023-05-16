class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    if current_user.nil?
      redirect_to new_user_session_path, alert: "Veuillez vous connecter."
    else
      @event = Event.new
    end
  end

  def create
    @event = Event.new(event_params)
    @event.admin = current_user
    
    if @event.save
      redirect_to @event, notice: "L'événement à été créé avec succès."
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location)
  end

end
