module InvitesHelper
  def guests_status(count, status)
    "#{to_human(count)} #{'guest'.pluralize(count)} #{status}"
  end

  def to_human(number)
    hash = Hash.new { |k, v| hash[k] = v }

    letter_numbers = 
    {
      1 => 'One', 2 => 'Two', 3 => 'Three', 4 => 'Four', 5 => 'Five', 6 => 'Six',
      7 => 'Seven', 8 => 'Eight', 9 => 'Nine', 10 => 'Ten', 11 => 'Eleven', 12 => 'Twelve'
    }

    hash.merge(letter_numbers)[number]
  end
end
