class UsersController < ApplicationController
before_filter :check_administrator_role, :only => [:index, :destroy, :enable]
before_filter :login_required, :only => [:show, :edit, :update]

#before_filter :require_current_user

def index
@users = User.find(:all)
end

def show
  @user = User.find_by_username(params[:username])#.find(params[:id])
  if(!@user.nil?)
    @user_detail = UserDetail.find_by_user_id(@user.id)
    if(@user_detail.nil?)
      @user_detail = UserDetail.new
      @user_detail.user_id = @user.id
      @user_detail.save
    end
    @friend_requests = Friendship.search_friend_request(@user.id)
    @friends = Friendship.search_all_friends(@user.id, Friendship::STATUS_ACCEPTED)
    @mobimates = User.find(:all, :limit => 5)#User.save_all_mobimates(@user.id)  this is temp commented
    @user_downloads = UserDetail.get_user_downloads(@user_detail)
    @user_uploads = UserDetail.get_user_uploads(@user_detail)
    @apps_suggestions = UserDetail.killermobi_apps_suggestion(@user_detail)
    @device = @user.get_virtual_device
    @real_devices = @user.get_real_devices
    @current_device = nil

    # variables for device
    @messages = UserMessage.all_message(@user, @current_device)
    @inbox_msg = UserMessage.all_inbox_msg(@user, @current_device)
    @outbox_msg = UserMessage.all_outbox_msg(@user, @current_device)
    @draft_msg = UserMessage.all_draft_msg(@user, @current_device)

  else
    render(:text => "Invalid url")
  end
end


def profile
  @profile_user = User.find_by_username(params[:username])
  user = logged_in_user
  @is_friend = false
  @is_friend = Friendship.is_my_friend?(user, @profile_user.id) if(!user.nil?)
end

def update_section
  section = params[:section].to_i
  @user = User.find_by_username(params[:update_section_uid])
  @user_detail = UserDetail.find_by_user_id(@user.id)
  @device = @user.get_virtual_device
  @real_devices = @user.get_real_devices

  # @friend_requests = Friendship.search_friend_request(@user.id)
  # @friends = Friendship.search_all_friends(@user.id, Friendship::STATUS_ACCEPTED)
  # @mobimates = User.save_all_mobimates(@user.id)
  # @user_downloads = UserDetail.get_user_downloads(@user_detail)
  @user_uploads = UserDetail.get_user_uploads(@user_detail)
  # @apps_suggestions = UserDetail.killermobi_apps_suggestion(@user_detail)

  if(section == UserDetail::MY_PROFILE_SECTION)
    render(:partial => "my_profile_show_partial")
  elsif(section == UserDetail::MY_UPLOADS_SECTION)
    render(:partial => "my_uploads_show_partial")
  elsif(section == UserDetail::MY_DEVICE_SECTION)
    @current_device = nil
    @current_device = RealDevice.find(:first, :conditions => "id = #{params[:device_id].to_i} and virtual_device = #{@device.id} and user_id = #{@user.id}") if(!params[:device_id].nil? && params[:device_id].to_i != 0)

    @messages = UserMessage.all_message(@user, @current_device)
    @inbox_msg = UserMessage.all_inbox_msg(@user, @current_device)
    @outbox_msg = UserMessage.all_outbox_msg(@user, @current_device)
    @draft_msg = UserMessage.all_draft_msg(@user, @current_device)

    if(!@device.nil?)
      render(:partial => "users/device/device_area")
    else
      render(:partial => "users/device/create_device")
    end
  end
end

def upload_profile_pic
  @pic_upload_status = nil
   if((params[:picture]) && !(params[:picture] == "") && !(params[:picture].original_filename.empty?))
     if not params[:picture].content_type.chomp =~ /^image/
       @pic_upload_status = "The file you uploaded isn't an image"
     else
       user = User.find_by_username(params[:username])
       @user_detail = UserDetail.find_by_user_id(user.id)
       begin
         path = "./public/user_data/profile_pic/original"
         FileUtils.mkdir_p(path)
         image_name = "#{RAILS_ROOT}/public/user_data/profile_pic/original/" + user.id.to_s
         @profile_pic = File.new(image_name + "_tmp_#{params[:picture].original_filename}", "wb")
         @profile_pic.write params[:picture].read
         @profile_pic.close
         @user_detail.update_attribute(:profile_pic_original,"/user_data/profile_pic/original/#{user.id.to_s}_tmp_#{params[:picture].original_filename}")
         rr = "public/user_data/profile_pic/original/#{user.id.to_s}_tmp_#{params[:picture].original_filename}"
         ww = "public/user_data/profile_pic/thumbnail/#{user.id.to_s}_#{user.username}_profile_pic.gif"
         system("#{User.convert} #{rr} -resize 100x120 #{ww}")
         @user_detail.update_attribute(:profile_pic, "/user_data/profile_pic/thumbnail/#{user.id.to_s}_#{user.username}_profile_pic.gif")
         @pic_upload_status = "Image changed sucessfully"
       rescue Exception => e
         @pic_upload_status = "Error in uploading image please try again #{e.to_s}"
       end
     end
  end
    render(:partial => "changed_profile_pic")
end

def upload_app_image
  @msg = ""
  @img = ""
  u = logged_in_user
  if(!u.nil?)
    if(!params[:image_type].nil?)
      if(!params[:upload_app_id].nil?)
        u_app = Download.find_by_id(params[:upload_app_id].to_i)
        if(!u_app.nil?)
          if((params[:app_image]) && !(params[:app_image] == "") && !(params[:app_image].original_filename.empty?))
            if not params[:app_image].content_type.chomp =~ /^image/
              @msg = "The file you uploaded isn't an image"
            else
              begin
                path = "./public/user_data/uploaded_apps/#{u.id}/#{u_app.id}/images"
                FileUtils.mkdir_p(path)
                app_file = "/public/user_data/uploaded_apps/#{u.id}/#{u_app.id}/images/#{params[:app_image].original_filename}"
                new_app_file = File.new("#{RAILS_ROOT}"+app_file, "wb")
                new_app_file.write params[:app_image].read
                new_app_file.close
                app_file = "/user_data/uploaded_apps/#{u.id}/#{u_app.id}/images/#{params[:app_image].original_filename}"
                if(params[:image_type] == "logo")
                  u_app.logo_url = app_file;
                elsif(params[:image_type] == "ss1")
                  u_app.ss1url = app_file
                elsif(params[:image_type] == "ss2")
                  u_app.ss2url = app_file
                elsif(params[:image_type] == "ss3")
                  u_app.ss3url = app_file
                elsif(params[:image_type] == "ss4")
                  u_app.ss4url = app_file
                elsif(params[:image_type] == "ss5")
                  u_app.ss5url = app_file
                elsif(params[:image_type] == "ss6")
                  u_app.ss6url = app_file
                elsif(params[:image_type] == "ss7")
                  u_app.more_ss = app_file
                end
                u_app.save_with_validation(false)
                @img = "/user_data/uploaded_apps/#{u.id}/#{u_app.id}/images/#{params[:app_image].original_filename}"
              rescue Exception => e
                @msg = "Error in uploading file. Please try again.#{e.to_s}"
              end
            end
          end
        end
      end
    end
  end
  render(:partial => "uploaded_file")
end

def upload_app_step1
  u = logged_in_user
  if(!u.nil?)
    dwld = Download.new
    dwld.title = params[:upload_title]
    dwld.category_id = params[:upload_category].to_i
    dwld.version = params[:upload_version].to_f
    dwld.type = Download::APP_USER_UPLOADED
    dwld.short_description = params[:upload_caption]
    dwld.description = params[:upload_desc]
    dwld.powered_by = params[:upload_pwrd_by]
    dwld.comurl = params[:upload_host_url]
    dwld.user_id = u.id
    dwld.status = Download::APP_UPLOADED
    dwld.save
  end
  render(:partial => "upload_apps_form_view2", :locals => {:upload_app_id => dwld.id })
end

def share_app_step1
  u = logged_in_user
  if(!u.nil?)
    dwld = Download.new
    dwld.title = params[:share_title]
    dwld.category_id = params[:share_category].to_i
    dwld.version = params[:share_version].to_f
    dwld.type = Download::APP_USER_SHARED
    dwld.short_description = params[:share_caption]
    dwld.description = params[:share_desc]
    dwld.powered_by = params[:share_pwrd_by]
    dwld.comurl = params[:share_host_url]
    dwld.user_id = u.id
    dwld.status = Download::APP_UPLOADED
    dwld.save
  end
  render(:partial => "share_apps_form_view2", :locals => {:share_app_id => dwld.id })
end


def edit_social_profile
  msg = "Social profiles updated!"
  begin
    user = User.find_by_username(params[:username])
    user_detail = UserDetail.find_by_user_id(user.id)
    user_detail.update_attribute(:fb_profile, params[:fb_url].to_s)
    user_detail.update_attribute(:twitter_profile, params[:twitter_url].to_s)
    user_detail.update_attribute(:google_profile, params[:google_url].to_s)
    user_detail.update_attribute(:blog_url, params[:blog_url].to_s)
  rescue
    msg = "Error in updating! please try again"
  end
  render(:text => msg)
end




# action for device ###################################################################################
def create_virtual_device
  @user = logged_in_user
  @user_detail = UserDetail.find_by_user_id(@user.id)
  name = params[:virtual_device_name]
  if(!@user.nil?)
    @device = VirtualDevice.create_device(@user.id, name)
    render(:partial => "users/device/device_area")
  end
end

def create_real_device
  @user = logged_in_user
  @user_detail = UserDetail.find_by_user_id(@user.id)
  name = params[:real_device_name]
  if(!@user.nil?)
    device = RealDevice.create_device(@user.id, name, @user_detail.virtual_device, random_alphanumeric(6))
    @real_devices = @user.get_real_devices
    render(:partial => "users/device/real_device_access_code", :locals => {:access_token => device.access_token })
  end
end

def send_user_message
  render(:text => "")
end

###################################################################################


def show_by_username
@user = User.find_by_username(params[:username])
render :action => 'show'
end

def new
@user = User.new
end

def create
@user = User.new(params[:user])
country = params[:country]
handset = params[:handset]
if(@user.save)
user_detail = UserDetail.new
user_detail.user_id = @user.id
user_detail.created_at = Time.now
user_detail.save
self.logged_in_user = @user
@user.update_attribute(:country,country)
@user.update_attribute(:handset,handset)
Notifier.deliver_new_user_registration(@user.username)
redirect_to index_url
else
render :action => 'new'
end
end

def edit
@user = logged_in_user
end

def update
if(!@current_user.nil?)
if(@current_user.fb_signup == 0)
@user = User.find(logged_in_user)
country = params[:country]
handset = params[:handset]
if @user.update_attributes(params[:user])
@user.update_attribute(:country,country)
@user.update_attribute(:handset,handset)
@user.update_attribute(:fb_signup,1)
redirect_to index_url
end
end
else
@user = User.find(logged_in_user)
if @user.update_attributes(params[:user])
redirect_to index_url
else
flash[:error] = "There was a problem in submitting details"
end
end
end

def destroy
@user = User.find(params[:id])
if @user.update_attribute(:enabled, false)
flash[:notice] = "User disabled"
else
flash[:error] = "There was a problem disabling this user."
end
redirect_to :action => 'index'
end

def enable
@user = User.find(params[:id])
if @user.update_attribute(:enabled, true)
flash[:notice] = "User enabled"
else
flash[:error] = "There was a problem enabling this user."
end
redirect_to :action => 'index'
end

# checking availability of user model ############################################
def availability_username
username = params[:username]
user = User.find_by_username(username)
if user
message = 'Sorry Not Available!'
@avail = false
else
message = 'Available'
@avail = true
end
@message = "<div><div>#{message}</div>"
render :partial => 'message'
end

def availability_email
email = params[:email]
user = User.find_by_email(email)
if user
message = 'Email already registered'
@avail = false
else
message = 'Available'
@avail = true
end
@message = "#{message}"
render :partial => 'message'
end
##################################################################################

#Facebook to KillerMobi migration ################################################
def migrate_fb_km
@mig_user = User.authenticate(params[:user][:username],params[:user][:password])
fb_id = @current_user.facebook_id
if !@mig_user.nil?
@current_user.update_attribute(:facebook_id,11111)
@mig_user.update_attribute(:facebook_id,fb_id)
@mig_user.update_attribute(:facebook_session_key,@current_user.facebook_session_key)
@mig_user.update_attribute(:firstname,@current_user.firstname)
@mig_user.update_attribute(:lastname,@current_user.lastname)
@mig_user.update_attribute(:fb_signup,1)
session[:user_id] = @mig_user.id
session[:user] = @mig_user.id
@logged_in_user = @mig_user
@current_user.destroy
@current_user = @mig_user
redirect_to index_url
else
flash[:error] = "Incorrect Username Or Password!"
end
end
##################################################################################

end

