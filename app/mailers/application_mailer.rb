# frozen_string_literal: true

# Mailer Configuration
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
