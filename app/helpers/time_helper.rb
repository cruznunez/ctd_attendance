module TimeHelper
  def full_date(time)
    return '<i>missing</i>'.html_safe unless time.respond_to?(:strftime)
    time.strftime('%-m/%-d/%Y %l:%M%P')
  end

  def just_date(date)
    return '<i>missing</i>'.html_safe unless date.respond_to?(:strftime)
    date.strftime('%-m/%-d/%Y')
  end
end
