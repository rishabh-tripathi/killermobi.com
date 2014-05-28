class DeviceController < ApplicationController
before_filter :check_auth, :except => [:app_user_login, :login_form]
before_filter :check_app_tokens, :only => [:app_user_login]

  def check_app_tokens
    if(!params[:app_id].nil? && !params[:app_key].nil?)

    end
    return true
  end

  def check_auth
    exception = false
    if(!params[:authenticaton_token].nil?)
      begin
        @device = RealDevice.search_by_authentication_token(params[:authenticaton_token])
        @user = User.find(@device.user_id)
        @user_detail = UserDetail.find_by_user_id(@user.id)
      rescue Exception => e
        exception = true
      end
    else
      exception = true
    end
    if(exception)
      render(:text => "Not a valid token")
    end
  end

  def app_user_login
    if(!params[:spam_id].nil? && check_real_spam_id(params[:spam_id]))
      user = nil
      token = random_alphanumeric(30)
      sync_token = random_alphanumeric(10)
      if(!params[:username].nil? && !params[:password].nil? && !params[:username].blank? && !params[:password].blank?)
        user = User.authenticate(params[:username], params[:password])
        if(!user.nil?)
          devices = RealDevice.find(:all, :conditions => "user_id = #{user.id}")
          if(!devices.nil? && !devices.empty?)
            txt_a = []
            for d in devices
              d.update_attribute(:logged_in_via, "#{RealDevice::APP_CODE_KILLERMOBI}:#{RealDevice::APP_USER_ACCESS_TOKEN_REQUIRED}")
              txt_a << "#{d.access_token}:#{d.name}"
            end
            if(!txt_a.empty?)
              render(:text => txt_a.join(",").to_s)
            end
          else
            render(:text => "No device added")
          end
        else
          render(:text => "Username/password incorrect")
        end
      elsif(!params[:access_token].nil? && !params[:access_token].blank?)
        device = RealDevice.search_by_access_code(params[:access_token].to_s)
        if(!device.nil?)
          user = User.find(device.user_id)
          device.update_attribute(:authentication_tokens, token.to_s)
          device.update_attribute(:sync_token, sync_token.to_s)
          device.update_attribute(:logged_in_via, "#{RealDevice::APP_CODE_KILLERMOBI}:#{RealDevice::APP_USER_LOGGED_IN}")
        end
        if(!user.nil?)
          render(:text => "#{token}")
        else
          render(:text => "You are not authorized")
        end
      end
      else
        render(:text => "We are not here to serve this type of request")
      end
  end

  def app_user_logout
    @device.update_attribute(:authentication_tokens, "")
    @device.update_attribute(:sync_token, "")
    app_code = device.logged_in_via.split(":")
    @device.update_attribute(:logged_in_via, "#{app_code[0]}:#{RealDevice::APP_USER_LOGOUT}")
    render(:text => "#{RealDevice::LOGGED_OUT_SUCCESSFUL}")
  end


  # login form for mobile ###############################################
  def login_form
    app_id = nil
    app_key = nil
    if(!params[:app_id].nil?)
      app_id = params[:app_id]
    end
    if(!params[:app_key].nil?)
      app_key = params[:app_key]
    end
    render(:partial => "users/device/login_form", :locals => {:app_key => app_key, :app_id => app_id}, :layout => false)
  end
  #######################################################################

  # actions for user messages
  def upload_user_message
    begin
      to = params[:to]
      from = params[:from]
      type = params[:type].to_i
      body = params[:body]
      received_at = params[:received_at]
      UserMessage.save_message(@user.id, @user_detail.virtual_device,  @device.id , to, from, type, body, received_at)
      render(:text => "10")
    rescue Exception => e
      render(:text => "-10")
    end
  end
end
