ActionMailer::Base.smtp_settings = {
  :address              => "mail.killermobi.com",
  :domain               => "killermobi.com",
  :port => 25,
  :authentication => :login,
  :user_name            => "no-reply@killermobi.com",
  :password             => "rish2319",
}
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = false
ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.default_url_options[:host] = "http://killermobi.com"
ActionMailer::Base.default_url_options[:host] = "localhost:3000" if Rails.env.development?
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
