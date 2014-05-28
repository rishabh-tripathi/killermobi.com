class UserMailer < ActionMailer::Base
  default :from => "support@killermobi.com"

  # this method send email after registered user download any app
  def after_download_notification(user,download)
    @user = user
    @download = download
    # attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    # mail(:to => "#{user.firstname} <#{user.email}>", :subject => "Thank you for using KillerMobi", :from => "contact@killermobi.com")
    mail(:to => "#{user.firstname} <#{user.email}>", :subject => "Thank you for using KillerMobi")
  end

  #this method send email after submission of new idea
  def after_idea_notification(user)
    @user = user
    mail(:to => "#{user.firstname} <#{user.email}>", :subject => "Thank you for your submission at KillerMobi")
  end

  def send_notification_to_all(user, subject, content) #add attachment functionality later
    @user = user
    @content = content
    mail(:to => "#{user.firstname} <#{user.email}>", :subject => "#{subject}")
  end

  def mnl_missing_code_notification(detail)
    @detail = detail
    mail(:to => "rishabh <rishabh@killermobi.com>", :subject => "New code submission for Mobile Number Tracer")
  end

  def contact_us_mail(name, email, subject, message)
    @name = name
    @email = email
    @message = message
    @subject = subject
    mail(:to => "rishabh <rishabh@killermobi.com>", :subject => "New message from KillerMobi users")
  end

  # method to send email from share this in mobile app ###################################
  def share_this_mobile_mail(email, ap, msg)
    @app = Download.find_by_title(ap)
    @msg = msg
    mail(:to => "#{email} <#{email}>", :subject => "Your friend has recommanded you to use #{@app.title}")
  end

  def feedback_mobile_mail(email, ap, msg)
    @app = Download.find_by_title(ap)
    @msg = msg
    @email = email
    mail(:to => "rishabh <rishabh@killermobi.com>", :subject => "Feedback from #{@app.title} user")
  end
end
