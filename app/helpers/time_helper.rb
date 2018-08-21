module TimeHelper
  def full_date(time)
    return '<i>missing</i>'.html_safe unless time.respond_to?(:strftime)
    time.strftime('%-m/%-d/%Y %l:%M%P')
  end
end
