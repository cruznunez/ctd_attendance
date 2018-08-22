# frozen_string_literal: true
module Email
  module Helpers
    def get_message_part(mail, content_type, alt: false)
      # alt stands for multipart/alternative
      part = mail
      part = mail.body.parts.find { |x| x.content_type[/alternative/] } if alt
      part.body.parts.find { |x| x.content_type[content_type] }.body.raw_source
    end
  end
end
