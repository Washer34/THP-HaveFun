class EventsController < ApplicationController

  before_action :authenticate_admin!, only: [:edit, :update, :destroy]

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
      flash[:alert] = @event.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = "Event mis à jour avec succès."
      redirect_to event_path(@event)
    else
      redirect_to edit_event_path(@event)
      flash[:alert] = @event.errors.full_messages.join(", ")
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Événement supprimé avec succès."
    redirect_to events_path
  end

  private

  def authenticate_admin!
    @event = Event.find(params[:id])
    unless current_user == @event.admin
      flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
      redirect_to events_path
    end
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location)
  end

end
