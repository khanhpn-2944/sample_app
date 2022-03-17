class ApplicationMailer < ActionMailer::Base
  default from: ENV["MAILER"]
  layout "mailer"
end
