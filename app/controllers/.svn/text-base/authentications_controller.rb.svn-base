class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = nil
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    user = nil
    # logger.info("\n\n\n\n\n\n=== #{omniauth.to_yaml}\n\n\n\n\n\n\n")
    user = nil
    if(omniauth['provider'] == "facebook")
      user = User.find_by_email(omniauth['extra']['user_hash']['email'].to_s) if(!omniauth['extra']['user_hash']['email'].nil? && !omniauth['extra']['user_hash']['email'].empty?)
    elsif(omniauth['provider'] == "google")
      user = User.find_by_email(omniauth['user_info']['email'].to_s) if(!omniauth['user_info']['email'].nil? && !omniauth['user_info']['email'].empty?)
    end
    if authentication
      # logger.info("\n\n\n\n\n\n----------- 1")
      flash[:notice] = "Signed in successfully."
      u_detail = nil
      u_detail = authentication.user.user_detail if(!authentication.user.user_detail.nil?)
      u_detail = UserDetail.new(:user_id => authentication.user.id) if(u_detail.nil?)
      token = ""
      token = omniauth['credentials']['token'] if(!omniauth['credentials'].nil? && !omniauth['credentials'].empty? && !omniauth['credentials']['token'].nil? && !omniauth['credentials']['token'].empty?)
      authentication.update_attribute(:access_token, token) if(authentication.access_token.empty?)
      (authentication.user, u_detail) = Authentication.assign_facebook_data_to_user(authentication.user, u_detail, omniauth, true)
      authentication.user.save
      u_detail.save
      sign_in_and_redirect(:user, authentication.user)

    elsif(!current_user.nil?)
      # logger.info("\n\n\n\n\n\n----------- 2")
      u_detail = current_user.user_detail
      u_detail = UserDetail.new(:user_id => current_user.id) if(u_detail.nil?)
      token = ""
      token = omniauth['credentials']['token'] if(!omniauth['credentials'].nil? && !omniauth['credentials'].empty? && !omniauth['credentials']['token'].nil? && !omniauth['credentials']['token'].empty?)
      auth = current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :access_token => token)
      (current_user, u_detail) = Authentication.assign_facebook_data_to_user(current_user, u_detail, omniauth, true)
      current_user.save
      u_detail.save
      flash[:notice] = "Authentication successful."
      redirect_to root_path

    elsif(!user.nil?)
      # logger.info("\n\n\n\n\n\n----------- 3")
      u_detail = user.user_detail
      u_detail = UserDetail.new(:user_id => user.id) if(u_detail.nil?)
      token = ""
      token = omniauth['credentials']['token'] if(!omniauth['credentials'].nil? && !omniauth['credentials'].empty? && !omniauth['credentials']['token'].nil? && !omniauth['credentials']['token'].empty?)
      auth = user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :access_token => token)
      (user, u_detail) = Authentication.assign_facebook_data_to_user(user, u_detail, omniauth, true)
      user.save
      u_detail.save
      flash[:notice] = "Authentication successful."
      sign_in_and_redirect(:user, user)

    else
      # logger.info("\n\n\n\n\n\n----------- 4")
      user = User.new
      if(omniauth['provider'] == "facebook")
        user.email = omniauth['extra']['user_hash']['email']
      elsif(omniauth['provider'] == "twitter")
        user.email = "#{omniauth['uid']}-no-email-with-email@no-email-available.xxx"
      elsif(omniauth['provider'] == "google")
        user.email = omniauth['user_info']['email']
      end

      auth = user.apply_omniauth(omniauth)
      if user.save
        # logger.info("\n\n\n\n\n\n----------- 5")
        u_detail = UserDetail.new(:user_id => user.id)
        (user, u_detail) = Authentication.assign_facebook_data_to_user(user, u_detail, omniauth, true)
        user.save
        u_detail.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        # logger.info("\n\n\n\n\n\n----------- 6")
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end


  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

  def blank
    render :text => "Not Found", :status => 404
  end

  def third_party_auth
  end
end
