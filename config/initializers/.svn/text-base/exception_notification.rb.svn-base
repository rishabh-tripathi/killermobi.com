if Rails.env.production?
  Rails.application.config.middleware.use ExceptionNotifier,
    :email_prefix => "[ERROR]",
    :sender_address => '"Bug" <no-reply@killermobi.com>',
    :exception_recipients => ['rishabh@killermobi.com']
end
