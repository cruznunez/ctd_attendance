# Or wrap things up in your own class
class Slack
  include HTTParty
  base_uri 'slack.com'

  def initialize
    @options = {
      query: {
        token: 'xoxp-7493619110-19410363652-254346946724-ac02dbe582a82f95a3a1ccb0d4358324'
      }
    }
  end

  def users
    JSON.parse(self.class.get('/api/users.list', @options).body)['members']
  end
end
