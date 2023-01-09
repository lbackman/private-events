module EventsHelper
  def past_or_future_guests(event)
    past?(event) ? "Guests" : "Confirmed guests"
  end

  def future?(event)
    event.date > Time.now
  end

  def past?(event)
    event.date < Time.now
  end
end
