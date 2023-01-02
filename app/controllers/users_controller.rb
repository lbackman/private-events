class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @user.events
  end
end
