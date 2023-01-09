module EventsHelper
  def past_or_future_guests(event)
    event.date < Time.now ? "Guests" : "Confirmed guests"
  end
end
