class UsersController < ApplicationController
  after_action :verify_authorized

  def show
    @user = User.find(params[:id])
    authorize @user
  end
end
