module ApplicationHelper

  def formatted_date(date)
    date.strftime("%d/%m/%y") if date.present?
  end

end