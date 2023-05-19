class Admin::EventsController < ApplicationController
  before_action :require_admin
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.order(:status)
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
      redirect_to new_event_path
    end
  end

  def edit
    
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    
    if @event.update(event_params)
      if params[:event][:photo].present?
        @event.photo.attach(params[:event][:photo])
      end
      redirect_to admin_events_path, notice: 'Event mis à jour avec succès.'
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path, notice: 'Event supprimé avec succès.'
  end

  private
  
  def set_event
    @event = Event.find(params[:id])
  end

  def require_admin
    unless current_user && current_user.is_admin?
      flash[:alert] = "Accès non autorisé"
      redirect_to root_path
    end
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location, :photo, :status)
  end

end
