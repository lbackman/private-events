module DateHelper
  def date_informal(date)
    if date.year == Time.now.year
      date.strftime("%A %b %-d, %H:%M")
    else
      date.strftime("%A %b %-d %Y, %H:%M")
    end
  end
end
