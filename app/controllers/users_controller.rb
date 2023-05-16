class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show, :edit_profile, :update_profile]
  
  def show
    unless current_user == @user
      redirect_to root_path, alert: "Accès non autorisé."
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def edit_profile
  end

  def update_profile
    if @user.update(user_params)
      flash[:notice] = "Profil mis à jour avec succès."
      redirect_to user_path(@user)
    else
      render :edit_profile
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description)
  end

end