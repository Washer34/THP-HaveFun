class Admin::AdminController < ApplicationController
  def index
    @user = current_user
    @pending_events_count = Event.pending.count
  end
end