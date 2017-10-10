# Or wrap things up in your own class
class Slack
  include HTTParty
  base_uri 'slack.com'

  def initialize
    @options = { query: { token: ENV['SLACK_KEY'] } }
  end

  def users
    JSON.parse(self.class.get('/api/users.list', @options).body)['members']
  end
end
