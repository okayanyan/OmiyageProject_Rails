class ApplicationMailer < ActionMailer::Base
  default from: "noreplay-#{ENV['SERVICE_EMAIL']}"
  layout 'mailer'
end
