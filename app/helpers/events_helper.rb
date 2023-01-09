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

  def user_hosted_events(current, user, time)
    current == user ? "My #{time} events" : "#{time.capitalize} events hosted by #{user.username}"
  end
end
