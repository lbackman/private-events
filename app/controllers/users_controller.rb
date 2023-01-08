class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find_by_id(params[:id])

    content_not_found unless @user.present?
  end
end
