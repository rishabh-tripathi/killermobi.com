class ApplicationController < ActionController::Base
#  protect_from_forgery
  helper :all
  include LoginSystem

  before_filter :detect_browser
  before_filter :set_assumptions

  MOBILE_BROWSERS = ["android", "ipod", "iphone", "opera mini", "blackberry", "palm", "hiptop", "avantgo", "plucker", "xiino", "blazer", "elaine", "windows ce; ppc;", "windows ce; smartphone;", "windows ce; iemobile", "up.browser", "up.link", "mmp", "symbian", "smartphone", "midp", "wap", "vodafone","o2", "pocket","kindle", "mobile", "pda", "psp", "treo"]
  HIGH_END_MOBILE = ["android", "ipod", "iphone"]

  def detect_browser
    agent = request.headers["HTTP_USER_AGENT"]
    @wapsite = false
    @high_end_mobile = false
    if(!agent.nil? && !agent.empty? && (MOBILE_BROWSERS.include? agent.downcase))
      @wapsite = true
      if(HIGH_END_MOBILE.include? agent.downcase)
        @high_end_mobile = true
      end
    end
  end

  def set_assumptions
    @app_settings = '{}'
  end
  private :set_assumptions

helper_method :get_random_spam_id
def get_random_spam_id
  key = SpamId.get_random_spam_id
  return key
end

helper_method :check_real_spam_id
def check_real_spam_id(id)
  return SpamId.check_spam_id(id)
end

helper_method :random_alphanumeric
def random_alphanumeric(size = 6)
  return Util.random_alphanumeric(size)
end


# function for killermobi profile #########################################
helper_method :refresh_device
def refresh_device(device_id)
  return "document.getElementById('new_device_id').value='#{ device_id }';document.getElementById('form_update_refresh_device').onsubmit();"
end

##########################################################################






private
  # Overwriting the sign_in and sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource_or_scope)
    root_path
  end

end
