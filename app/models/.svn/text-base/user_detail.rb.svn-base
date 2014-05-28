class UserDetail < ActiveRecord::Base
  belongs_to :user

  MY_PROFILE_SECTION = 10
  MY_FRIENDS_SECTION = 20
  MY_MOBIMATES_SECTION = 30
  MY_DOWNLOADS_SECTION = 40
  MY_UPLOADS_SECTION = 50
  KILLERMOBI_SUGGESTIONS_SECTION = 60
  MY_DEVICE_SECTION = 70

  MY_PROFILE_IDS = {
    MY_PROFILE_SECTION => "my_profile_section",
    MY_FRIENDS_SECTION => "my_friends_section",
    MY_MOBIMATES_SECTION => "my_mobimates_section",
    MY_DOWNLOADS_SECTION => "my_downloads_section",
    MY_UPLOADS_SECTION => "my_uploads_section",
    KILLERMOBI_SUGGESTIONS_SECTION => "killermobi_suggestions_section",
    MY_DEVICE_SECTION => "my_device_section",
  }

  MY_PROFILE_LOADING_IDS = {
    MY_PROFILE_SECTION => "loading_my_profile",
    MY_FRIENDS_SECTION => "loading_my_friends",
    MY_MOBIMATES_SECTION => "loading_my_mobimates",
    MY_DOWNLOADS_SECTION => "loading_my_downloads",
    MY_UPLOADS_SECTION => "loading_my_uploads",
    KILLERMOBI_SUGGESTIONS_SECTION => "loading_killermobi_suggestions",
    MY_DEVICE_SECTION => "loading_my_device"
  }

  def self.get_user_uploads(user_detail)
    upld_ids = []
    upld_ids = user_detail.upld_apps_ids.split(":") if(!user_detail.upld_apps_ids.nil?)
    uploads = nil
    if(upld_ids.size>0)
      uploads = Download.find(:all, :conditions => "id in (#{upld_ids.join(',')})")
    end
    return uploads
  end

  def self.set_user_uploads(user_detail, id)
    uploaded_ids = []
    uploaded_ids = user_detail.upld_apps_ids.split(":") if(Util.none(user_detail.upld_apps_ids))
    update = false
    if(Util.none(uploaded_ids))
      update = true
      uploaded_ids << id if(!(uploaded_ids.include? id))
    end
    user_detail.update_attribute(:upld_apps_ids, uploaded_ids.uniq.join(',')) if(update)
  end

  def self.get_user_downloads(user_detail)
    dwld_ids = []
    dwld_ids = user_detail.dwld_apps_ids.split(":") if(!user_detail.dwld_apps_ids.nil?)
    downloads = nil
    if(dwld_ids.size>0)
      downloads = Download.find(:all, :conditions => "id in (#{dwld_ids.join(',')})")
    end
    return downloads
  end

  def self.killermobi_apps_suggestion(user_detail)
    upld = user_detail.upld_apps_ids
    dwld = user_detail.dwld_apps_ids
    ex_apps = ""
    ex_apps += upld.gsub(/(:)/,",") if(!upld.empty?)
    ex_apps += dwld.gsub(/(:)/,",") if(!dwld.empty?)
    download = Download.find(:all, :conditions => "download_count > 50 and id not in ('#{ex_apps}')", :order => "download_count desc", :limit => 45)
    return download
  end
end
