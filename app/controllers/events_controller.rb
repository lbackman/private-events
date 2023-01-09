class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @future_events = Event.future.limit(10)

    @past_events = Event.past.limit(10)
  end

  def show
    @event = Event.find_by_id(params[:id])

    content_not_found unless @event.present?
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
  
    if @event.save
      redirect_to root_path, notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy

    redirect_to root_path, status: :see_other, notice: "Event canceled."
  end

  private

    def event_params
      params.require(:event).permit(:date)
    end
end
