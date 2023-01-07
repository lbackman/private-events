class InvitesController < ApplicationController
  before_action :get_event, only: [:index, :new, :create, :destroy]
  before_action :get_attendee, only: [:show, :edit, :update]

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
    @invite = Invite.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
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
end
