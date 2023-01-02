class EventsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @user = current_user
    @event = @user.events.build(event_params)
  
    if @event.save
      redirect_to root_path, notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def event_params
      params.require(:event).permit(:date)
    end
end
