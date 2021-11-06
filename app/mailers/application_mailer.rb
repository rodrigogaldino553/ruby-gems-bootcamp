class ApplicationMailer < ActionMailer::Base
  default from: "Corsego <#{ENV['TEST_CONTACT_EMAIL']}>"
  layout 'mailer'
end
