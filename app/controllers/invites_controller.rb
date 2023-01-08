class InvitesController < ApplicationController
  before_action :get_event, only: [:index, :new, :create, :destroy]
  before_action :get_attendee, only: [:show, :accept, :decline, :tentative]
  before_action :ensure_correct_creator!, only: [:index, :new, :create, :destroy]
  before_action :ensure_correct_attendee!, only: [:show, :accept, :decline, :tentative]

  def new
    @invites = @event.invites.build
  end

  def create
    begin
      Invite.transaction do
        # binding.irb
        @invites = @event.invites.create!(invites_params)
        redirect_to event_path(@event), notice: "Succesfully sent"
      end
    rescue ActiveRecord::RecordInvalid => exception
      # omitting the exception type rescues all StandardErrors
      @invites = {
        error: {
          status: 422,
          message: exception
        }
      }
    end
    # binding.irb
    # @invites = @event.invites.build(invites_params)

    # if @invites.save
    #   redirect_to @event, notice: "Invite(s) sent successfully"
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end

  def show
    @invite = Invite.find_by_id(params[:id])

    content_not_found unless @invite.present?
  end

  def edit
  end

  def update
  end

  def accept
    @invite = @attendee.invites_received.find(params[:id])
    @invite.update_attribute(:accepted, true)

    redirect_to user_invite_path(@attendee, @invite)
  end

  def decline
    @invite = @attendee.invites_received.find(params[:id])
    @invite.update_attribute(:accepted, false)

    redirect_to user_invite_path(@attendee, @invite)
  end

  def tentative
    @invite = @attendee.invites_received.find(params[:id])
    @invite.update_attribute(:accepted, nil)

    redirect_to user_invite_path(@attendee, @invite)
  end

  def destroy
    @invite = @event.invites.find(params[:id])
    @invite.destroy

    redirect_to event_invites_path(@event), status: :see_other
  end

  private

    def invites_params
      # params.permit(invites: [:attendee_id]).require(:invites)
      invites = { invites: [] }
      params[:invite][:attendee_id].each do |id|
        unless id == ''
          invites[:invites] << {attendee_id: id.to_i}
        end
      end
      invite_params = ActionController::Parameters.new(invites)
      invite_params.permit(invites: [:attendee_id]).require(:invites)
    end

    def get_event
      @event = Event.find(params[:event_id])
    end

    def get_attendee
      @attendee = User.find(params[:user_id])
    end

    def ensure_correct_creator!
      unless current_user.id == @event.creator_id
        redirect_to event_path(@event), message: "can't send invites for other users"
      end
    end

    def ensure_correct_attendee!
      unless current_user.id == @attendee.id
        redirect_to user_path(@attendee), message: "can't edit other users' invites"
      end
    end
end
