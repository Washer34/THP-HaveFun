class AttendancesController < ApplicationController

  def index
    @event = Event.find(params[:event_id])
    @attendances = @event.attendances 
  end

  def new
    @event = Event.find(params[:event_id])
    @attendances = @event.attendances.build
  end

  def create
    @event = Event.find(params[:event_id])
    @attendance = Attendance.new(event: @event, guest: current_user)
    if @attendance.save
      redirect_to success_path
    else
      render :new
    end
  end



end
