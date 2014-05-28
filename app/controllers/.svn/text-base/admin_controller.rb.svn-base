require 'rubygems'
require 'tempfile'
require 'fileutils'

#require 'RMagick'
class AdminController < ApplicationController
skip_before_filter :verify_authenticity_token, :only => [:submit_one_app]
before_filter :check_administrator_role, :except=>[:submit_one_app]
before_filter :login_required

def experiment
  @aim = "Get all the downloads detail"
  user = User.find(:all)
  for u in user
    uds = UserDetail.find_by_user_id(u.id)
    if(uds.nil?)
      ud = UserDetail.new
      ud.user_id = u.id
      ud.save
    end
  end


=begin
  @download = Download.find(:all)

  for d in @download
    d.ss1url = "/#{d.ss1url}" if(Util.none(d.ss1url) && !d.ss1url.start_with?("/"))
    d.ss1_medium = "/#{d.ss1_medium}" if(Util.none(d.ss1_medium) && !d.ss1_medium.start_with?("/"))
    d.ss1_small = "/#{d.ss1_small}" if(Util.none(d.ss1_small) && !d.ss1_small.start_with?("/"))
    d.ss1_thumb = "/#{d.ss1_thumb}" if(Util.none(d.ss1_thumb) && !d.ss1_thumb.start_with?("/"))
    d.ss2url = "/#{d.ss2url}" if(Util.none(d.ss2url) && !d.ss2url.start_with?("/"))
    d.ss3url = "/#{d.ss3url}" if(Util.none(d.ss3url) && !d.ss3url.start_with?("/"))
    d.ss4url = "/#{d.ss4url}" if(Util.none(d.ss4url) && !d.ss4url.start_with?("/"))
    d.ss5url = "/#{d.ss5url}" if(Util.none(d.ss5url) && !d.ss5url.start_with?("/"))
    d.ss5url = "/#{d.ss6url}" if(Util.none(d.ss6url) && !d.ss6url.start_with?("/"))
    d.save
  end
=end

  # set access token for uploaded files #########
#  uploaded_files = UploadedFile.find(:all)
#  for u in uploaded_files
#    u.update_attribute(:token, random_alphanumeric(30))
#  end
  ###############################################

 # path = "./public/killer_downloads/killermobi/JADs/App1/AITalk.jad"
 # path1 = "./public/killer_downloads/killermobi/JADs/App1/atest.jad"

 # f = File.open(path, 'r')
 # file_data = f.read
 # f.close

#  @con = []
#  @final1 = []
#  @vendor = ""
#  @live = ""
#  @con = file_data.to_s.split(/\n/)

#  file_data = file_data.gsub(/(http:)\W\W[0-9.]*\W[a-zA-Z]*[a-zA-z\W0-9.]*(.jar)$/,"rishabh.jar")
  # @content = @con[4].gsub(/^(MIDlet-Vendor:)/,"")
  # @tent = []
  # @tent = @con[5].gsub(/^(MIDlet-1:)/,"").split(/,/)
  # @content = @tent[2]
#  file_data = file_data.gsub(/^(GetJarCampaignID:\s*[0-9]*)/,"")
#  file_data = file_data.gsub(/^(DOWNLOADED_WITH_USER_AGENT:\s*[a-zA-Z0-9\W_]*)/,"")
#  file_data = file_data.gsub(/^(DOWNLOAD_SOURCE:\s*[a-zA-Z0-9\W_]*)/,"")
#  file_data = file_data.gsub(/^(DOWNLOAD_UID:\s*[a-zA-Z0-9\W_]*)/,"")

#  f1 = File.new(path1,"w")
#  f1.puts file_data
#  f1.close
end

def index
  @download = Download.find(:all)
end

def edit
  @download = Download.find(params[:id])
end

def generate_new_spam_ids
  SpamId.generate
  render(:text => "New Spam Ids generated")
end

def generate_licence
  for a in (1..5000)
    @code = rand(10 ** 10).to_s.rjust(10,'0')
    @licence = Licence.new(:code=>@code,:status=>"0")
    @licence.save
  end
end

def licence
  @licence = Licence.find(:all)
end

def add_bulk
  @gj = Gj_app.paginate(:page => params[:page], :conditions=>"status = 1")
  @category = DownloadCategory.find(:all)
  @type = DownloadType.find(:all)
end

def submit_one_app
  msg = ""
  error = false
begin
  gj_url = params[:gj_id]
  cat = params[:download_category_id]
  type = params[:download_type_id]
  title = params[:dw_name].to_s
  short_disc = params[:dw_short_disc].to_s
  full_disc = params[:dw_full_disc].to_s
  file_name = params[:dw_filename].to_s
  use_original_disc = params[:fd_upload_original]

  @gj_app = Gj_app.find_by_gj_url(gj_url, :limit=>1)

  @download = Download.new
  @download.title = title #@gj_app.name
  @download.short_description = short_disc #@gj_app.short_disc
  if(use_original_disc == "original")
    @download.description = @gj_app.full_disc
  else
    @download.description = full_disc
  end

  if(@gj_app.file_name.end_with?(".jar"))
    begin
    read_path2 = "./public/killer_downloads/killermobi/JADs/App1/"+@gj_app.file_name.gsub(/.jar/,'')+".jad"
    write_path2 = "./public/killer_downloads/killermobi/JADs/"+file_name.gsub(/.jar/,'')+".jad"      #@gj_app.file_name.gsub(/.jar/,'')+".jad"
    write_bkup_path2 = "./public/killer_downloads/killermobi/JADs/"+file_name.gsub(/.jar/,'')+"_bkup.jad"

    f = File.open(read_path2, 'r')
    file_data = f.read
    f.close

    con = []
    vendor = ""
    con = file_data.to_s.split(/\n/)
    count = con.size
    for i in 0..count do
     if(con[i].to_s.include? "MIDlet-Vendor:")
       vendor = con[i].gsub(/^(MIDlet-Vendor:)/,"")
     end
    end

    file_data = file_data.gsub(/(http:)\W\W[0-9.]*\W[a-zA-Z]*[a-zA-z\W0-9.]*(.jar)$/,file_name)
    file_data = file_data.gsub(/^(GetJarCampaignID:\s*[0-9]*)/,"")
    file_data = file_data.gsub(/^(DOWNLOADED_WITH_USER_AGENT:\s*[a-zA-Z0-9\W_]*)/,"")
    file_data = file_data.gsub(/^(DOWNLOAD_SOURCE:\s*[a-zA-Z0-9\W_]*)/,"")
    file_data = file_data.gsub(/^(DOWNLOAD_UID:\s*[a-zA-Z0-9\W_]*)/,"")

    f1 = File.new(write_path2,"w")
    f1.puts file_data
    f1.close

    Download::move_file(read_path2,write_bkup_path2)
    @download.file2url = "killer_downloads/killermobi/JADs/"+file_name.gsub(/.jar/,'')+".jad"
    rescue => e
      msg = "prob in jad moving (#{e.to_s})"
      error = true
    end
  end

  read_path3 = "./public/killer_downloads/killermobi/ScreenShot1/App1/"+@gj_app.img_url.to_s
  write_path3 = "./public/killer_downloads/killermobi/ScreenShot1/"+@gj_app.img_url.to_s

  rr = "public/killer_downloads/killermobi/ScreenShot1/App1/"+@gj_app.img_url.to_s

  ww = "public/killer_downloads/killermobi/ScreenShot1/base/"+@gj_app.name.tr(" ","_")+"_killermobi_170x190.gif"
  ww1 = "public/killer_downloads/killermobi/ScreenShot1/medium/"+@gj_app.name.tr(" ","_")+"_killermobi_145x165.gif"
  ww2 = "public/killer_downloads/killermobi/ScreenShot1/small/"+@gj_app.name.tr(" ","_")+"_killermobi_100x120.gif"
  ww3 = "public/killer_downloads/killermobi/ScreenShot1/thumb/"+@gj_app.name.tr(" ","_")+"_killermobi_60x80.gif"

  @download.ss1url = "killer_downloads/killermobi/ScreenShot1/base/"+@gj_app.name.tr(" ","_")+"_killermobi_170x190.gif"
  @download.ss2url = "killer_downloads/killermobi/ScreenShot1/base/"+@gj_app.name.tr(" ","_")+"_killermobi_170x190.gif"
  @download.ss1_medium = "killer_downloads/killermobi/ScreenShot1/medium/"+@gj_app.name.tr(" ","_")+"_killermobi_145x165.gif"
  @download.ss1_small = "killer_downloads/killermobi/ScreenShot1/small/"+@gj_app.name.tr(" ","_")+"_killermobi_100x120.gif"
  @download.ss1_thumb = "killer_downloads/killermobi/ScreenShot1/thumb/"+@gj_app.name.tr(" ","_")+"_killermobi_60x80.gif"
  @download.powered_by = vendor if(!vendor.nil?)
  begin
  system("#{Gj_app.convert} #{rr} -resize 170x190 #{ww}")
  system("#{Gj_app.convert} #{rr} -resize 145x165 #{ww1}")
  system("#{Gj_app.convert} #{rr} -resize 100x120 #{ww2}")
  system("#{Gj_app.convert} #{rr} -resize 60x80 #{ww3}")
  rescue => e
    msg = msg+"Problem in converting image and moving (#{e.to_s})"
    error = true
  end
  #   img =  Magick::Image.read(read_path3).first
  #   base = img.resize(width, height)
  #   thumb.write("./public/killer_downloads/killermobi/ScreenShot1/"+@gj_app.name.tr(" ","_")+"_170x190.gif")

  @download.category_id = cat.to_i
  @download.type_id = type.to_i

  Download::move_file(read_path3,write_path3)

  begin
  @download.file1url = "killer_downloads/killermobi/JARs/"+file_name.to_s
  read_path1 = "./public/killer_downloads/killermobi/JARs/App1/"+@gj_app.file_name.to_s
  write_path1 = "./public/killer_downloads/killermobi/JARs/"+file_name.to_s
  Download::move_file(read_path1,write_path1)
  rescue => e
    msg = msg + "prob in moving file (#{e.to_s})"
    error = true
  end
rescue => e
  logger.info(e)
  error = true
end
begin
  if(!error)
    @download.save
  end
  @gj_app.status = 5
  @gj_app.save
  @gj_app.reload
rescue => e
  msg = msg + "misc error = #{e.to_s}"
end
# msg+="  "+cat+"  "+type+"  "+title+"  "+short_disc+"  "+full_disc+"  "+file_name
 render :text=> "=====>> Upload Successfully #{e}"+@gj_app.name.to_s+"--- msg ="+msg
end


# Admin mailing functionality ##############################################################
def send_notification
end

def send_notification_mail
  @user = User.find(:all)
  content = params[:mail][:content]
  subject = params[:mail][:subject]
  for user in @user
    if user.email.include? "@"
      if user.email.include? "."
        begin
          UserMailer.send_notification_to_all(user, subject, content).deliver
        rescue Exception => exc
          logger.error("Error in sending notification. Details :- #{exc.message}")
        end
      end
    end
  end
  redirect_to admin_notification_mail_url
end

##################################################################################







# Temp functions ############################################################################
#def migrate_user_details
# user = User.find(:all)
#  for u in user
#    uds = UserDetail.find(u.id)
#    if(uds.nil? || uds.empty?)
#      ud = UserDetail.new
#      ud.user_id = u.id
#      ud.save
#    end
#  end
#end
#
#def migrate_user_dwld
# user = User.find(:all)
#  for u in user
#    dwld = u.dwld_apps_ids
#    ud = UserDetail.find_by_user_id(u.id)
#    ud.dwld_apps_ids = dwld
#    ud.save
#  end
#end

def migrate_fb_users_to_authentication
  user = User.find(:all)
  for u in user
    if(!u.facebook_id.nil?)
      e = Authentication.find_by_uid(u.facebook_id.to_s)
      if(e.nil?)
        u.authentications.create!(:provider => "facebook", :uid => u.facebook_id.to_s, :user_id => u.id)
      end
    end
  end
end
####################################################################################################
end
