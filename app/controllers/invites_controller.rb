class InvitesController < ApplicationController
  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(invite_params)
  
    if @invite.save
      redirect_to "/events/#{params[:event_id]}", notice: "Invite was successfully sent."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @invite = Invite.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def invite_params
      params.require(:invite).permit(:event_id, :attendee_id)
    end
end
