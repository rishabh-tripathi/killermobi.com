class Authentication < ActiveRecord::Base
  belongs_to :user

  def provider_name
    if provider == 'open_id'
      "OpenID"
    else
      provider.titleize
    end
  end

  def save_access_token(token)
    update_attribute(:access_token, token.to_s)
  end

  def self.assign_facebook_data_to_user(user, u_detail, omniauth, force_update = false)
    require 'open-uri'
    begin
    ######################################################################
    # add fields to populate from facebook data
    if(!omniauth['user_info']['last_name'].nil? && !omniauth['user_info']['last_name'].empty?)
      user.lastname = omniauth['user_info']['last_name'] if(user.lastname.nil? || !user.lastname.empty? || force_update)
    end

    if(!omniauth['user_info']['first_name'].nil? && !omniauth['user_info']['first_name'].empty?)
      user.firstname = omniauth['user_info']['first_name'] if(user.firstname.nil? || user.firstname.empty? || force_update)
    end

    if(omniauth['provider'] == "twitter")
      if(!omniauth['user_info']['name'].nil? && !omniauth['user_info']['name'].empty?)
        user.firstname = omniauth['user_info']['name'] if(user.firstname.nil? || user.firstname.empty? || force_update)
      end
    end

    if(omniauth['provider'] == "facebook")
      u_detail.fb_profile = omniauth['user_info']['link'] if(!omniauth['user_info']['link'].nil? && !omniauth['user_info']['link'].empty?)
    elsif(omniauth['provider'] == "twitter")
      u_detail.twitter_profile = omniauth['user_info']['link'] if(!omniauth['user_info']['link'].nil? && !omniauth['user_info']['link'].empty?)
    elsif(omniauth['provider'] == "google")
      u_detail.google_profile = omniauth['uid'] if(!omniauth['uid'].nil? && !omniauth['uid'].empty?)
      user.username = omniauth['user_info']['email'].split("@").first if(user.username.nil? || user.username.empty?)
    end

    # getting user image using graph api
    if(!omniauth['user_info']['nickname'].nil? && !omniauth['user_info']['nickname'].empty?)
      user.username = omniauth['user_info']['nickname'].to_s if(user.username.nil? || user.username.empty?)
      if(omniauth['provider'] == "facebook")
        u_detail.profile_pic_original = "https://graph.facebook.com/#{omniauth['user_info']['nickname'].to_s}/picture?type=large"
        u_detail.profile_pic = "https://graph.facebook.com/#{omniauth['user_info']['nickname'].to_s}/picture"
      end
      user.username = omniauth['user_info']['nickname'].to_s if(!user.username.nil? && !user.username.empty?)
    end

    if(omniauth['provider'] == "twitter")
      if(!omniauth['user_info']['image'].nil? && !omniauth['user_info']['image'].empty?)
        u_detail.profile_pic = omniauth['user_info']['image']
        u_detail.profile_pic_original = u_detail.profile_pic
      end
    end

    #if(Util.none(omniauth['user_info']['gender']))
    #  gen = 1
    #  gen = 2 if(omniauth['user_info']['gender'].to_s = "female")
    #  user.gender = gen
    #end

    #if(Util.none(omniauth['user_info']['birthday']))
    #  dob = omniauth['user_info']['birthday'].to_s.split("/")
    #  user.dob_month = dob[0].to_i
    #  user.dob_day = dob[1].to_i
    #  user.dob_year = dob[2].to_i
    #end

    #if(!omniauth['user_info']['image'].nil? && !omniauth['user_info']['image'].empty?)
    #  image_name = "#{RAILS_ROOT}/public/user_data/profile_pic/"
    #  if(File.exist?("#{RAILS_ROOT}/public#{u_detail.profile_pic_original}") && force_update)
    #    File.delete("#{RAILS_ROOT}/public#{u_detail.profile_pic_original}")
    #  end
    #  if(File.exist?("#{RAILS_ROOT}/public#{u_detail.profile_pic}") && force_update)
    #    File.delete("#{RAILS_ROOT}/public#{u_detail.profile_pic}")
    #  end

    #  if(!File.exist?("#{RAILS_ROOT}/public#{u_detail.profile_pic_original}"))
    #    file = open(omniauth['user_info']['image'].to_s.gsub("square","large"))
    #    profile_pic = File.new(image_name + "original/#{user.id.to_s}.jpg", "wb")
    #    profile_pic.write file.read
    #    profile_pic.close
    #    #u_detail.profile_pic_original = "/user_data/profile_pic/original/#{user.id}.jpg"
    #    u_detail.profile_pic_original = omniauth['user_info']['image'].to_s.gsub("square","large")
    #    if(!File.exist?("#{RAILS_ROOT}/public#{u_detail.profile_pic}"))
    #      rr = "public/user_data/profile_pic/original/#{user.id.to_s}.jpg"
    #      ww = "public/user_data/profile_pic/thumbnail/#{user.id.to_s}.gif"
    #      system("#{User.convert} #{rr} -resize 100x120 #{ww}")
    #      #u_detail.profile_pic = "/user_data/profile_pic/thumbnail/#{user.id.to_s}.jpg"
    #      u_detail.profile_pic = omniauth['user_info']['image'].to_s
    #    end
    #  end
    #end

    #if(Util.none(omniauth['extra']['user_hash']['location']))
    #  user_location_city = omniauth['extra']['user_hash']['location']['name'].to_s.split(",").first
    #  user_location = City.cached_find_by_name(Util.deformat_text(user_location_city)) if(!user_location_city.nil?)
    #end

    #if(Util.none(omniauth['extra']['user_hash']['hometown']))
    #  user_hometown_city = omniauth['extra']['user_hash']['hometown']['name'].to_s.split(",").first
    #  user_hometown = City.cached_find_by_name(Util.deformat_text(user_hometown_city)) if(!user_hometown_city.nil?)
    #end

    #if(!user_location.nil?)
    #  if(Util.none(u_detail.lived_cities_id) && !(u_detail.lived_cities_id.include? user_location.name))
    #    u_detail.lived_cities_id += "#{user_location.name}:"
    #  else
    #    u_detail.lived_cities_id = ":#{user_location.name}:"
    #  end
    #end

    #if(!user_location.nil?)
    #  if((user.city_id.nil? || user.city_id==0) || force_update)
    #    user.city_id = user_location.id
    #  end
    #end

    #if(Util.none(omniauth['extra']['user_hash']['location']))
    #  if(user.country_id.nil? || user.country_id==0 || force_update)
    #    country = Country.search_by_name(omniauth['extra']['user_hash']['location']['name'].to_s.split(",").last)
    #    user.country_id = country.id if(!country.nil?)
    #  end
    #end

    #if(!user_hometown.nil?)
    #  if(Util.none(u_detail.lived_cities_id) && !(u_detail.lived_cities_id.include? user_hometown.name))
    #    u_detail.lived_cities_id += "#{user_hometown.name}:"
    #  else
    #    u_detail.lived_cities_id += ":#{user_hometown.name}:"
    #  end
    #end
    rescue Exception => ex
      logger.info("\n\n#{ex.to_s}\n\n")
      logger.info("\n\n#{ex.backtrace}\n\n")
    end
    return [user, u_detail]
  end

  ##############################################################################################################################################
  # Reference : https://developers.facebook.com/docs/reference/rest/stream.publish/
  # Parameters :
  #  user : User object on behalf of that the message will be posted
  #  message : String message use \n for new line, we can also post links.
  #  target_id : If we want to post message to a page rather then user's wall or some other user's page then it will be the id of that object
  #              The ID of the user, Page, group, or event where you are publishing the content. If you specify a target_id, the post appears on the   #              Wall of the target profile, Page, group, or event, not on the Wall of the user who published the post. This mimics the action of po   #              sting on a friend's Wall on Facebook itself.
  #              Note: If you specify a Page ID as the uid, you cannot specify a target_id. Pages cannot write on other users' Walls.
  #              Note: You cannot publish to an application profile page's Wall.
  #  uid : By default the message will be posted on behalf of the user but if we provide uid then message will be posted on behalf of that entity.     #        The ID of the user or Page publishing the post. If this parameter is not specified, then it defaults to the session user. If you want to    #        publish as page, you should use the 'enable_profile_selector' option with FB.login. This option enables the profile selector on the         #        permission dialog.
  #        Note: If you specify a Page ID as the uid, you cannot specify a target_id. Pages cannot write on other users' Walls.
  #  attachment_type : it could be "image"/"flash"/"mp3"
  #  attachment_hash : if we want to post images, flash or mp3 then it will be the hash of the media.
  #                    Eg. {"src of the media", "href link for the media"}
  #  action_link : action link which shown with like link on facebook post, this should be a hash
  #                eg. {"href link", "text to show"}
  ###############################################################################################################################################

=begin
  def self.post_to_facebook(user, message, target_id = nil, uid = nil, attachment_type = nil, attachment_hash = nil, action_link_hash = nil)
    require "open-uri"
    begin
      u_fb = user.authentications.find_by_provider(SocialAuth::FACEBOOK)

      # Adding attachment
      attachment_string = nil
      if(!attachment_hash.nil?)
        attachment_string = "{\"media\": ["
        attachment_a = []
        attachment_hash.each do|src, href|
          attachment_a << "{\"type\": \"#{attachment_type}\",\"src\": \"#{src}\",\"href\": \"#{href}\"}"
        end
        attachment_string += attachment_a.join(",")
        attachment_string += "]}"
      end

      # Adding Action Link which will be shown near like link on facebook page
      action_link_string = nil
      if(!action_link_hash.nil?)
        action_link_string = "["
        action_link_hash.each do |href, text|
          action_link_string += "{\"href\":\"#{href}\", \"text\":\"#{text}\"}"
        end
        action_link_string = "]"
      end

      url_str = "https://api.facebook.com/method/stream.publish?access_token=#{u_fb.access_token}"
      url_str += "&message=#{message}" if(Util.none(message))
      url_str += "&attachment=#{attachment_string}" if(Util.none(attachment_string))
      url_str += "&action_links=#{action_link_string}" if(Util.none(action_link_string))
      url_str += "&target_id=#{target_id}" if(Util.none(target_id))
      url_str += "&uid=#{uid}" if(Util.none(uid))

      url = URI.parse(URI.encode(url_str))
      response = nil
      response = open(url)
    rescue Exception => e
      puts e.to_s
    end

    if(!response.nil? && response.status[0]=="200")
      return true
    else
      return false
    end
  end
=end

end
