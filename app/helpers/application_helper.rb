module ApplicationHelper
  def alert_generator(msg, alert = 'alert-danger')
    <<-HTML.strip_heredoc
      <div class="alert #{alert}">
        <div class="msg">#{msg}</div>
        <div class="close" data-dismiss="alert"></div>
      </div>
    HTML
  end

  def flash_helper
    msgs = flash.map do |name, msg|
      alert = name == 'notice' ? 'green' : 'yellow'
      alert_generator msg, alert
    end

    msgs.join.html_safe
  end

  def date
    params[:date] || Date.today
  end
end
