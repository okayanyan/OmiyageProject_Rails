if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: ENV['SERVICE_EMAIL'][0, ENV['SERVICE_EMAIL'].index('@')],
    domain: ENV['SERVICE_EMAIL'][ENV['SERVICE_EMAIL'].index('@')+1, \
          ENV['SERVICE_EMAIL'].length - ENV['SERVICE_EMAIL'].index('@')],
    port: 1025,
    user_name: ENV['SERVICE_EMAIL'],
    password: ENV['SERVICE_EMAIL_PASSWORD'],
    authentication: 'plain',
    enable_starttls_auto: true
  }
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener_web
else
  ActionMailer::Base.delivery_method = :test
end