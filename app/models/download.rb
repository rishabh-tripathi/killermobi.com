class Download < ActiveRecord::Base
#acts_as_taggable
self.inheritance_column = ''
#before_save :save_cached_tag_list
belongs_to :download_category
belongs_to :download_type


# Apps platform
PLATFORM_ALL = 0
PLATFORM_J2ME = 100
PLATFORM_SYMBIAN = 200
PLATFORM_BLACKBERRY = 300
PLATFORM_ANDROID = 400
PLATFORM_WINDOWS = 500

PLATFORM_NAMES = {
    PLATFORM_ALL => "All",
    PLATFORM_J2ME => "JavaME",
    PLATFORM_SYMBIAN => "Symbian",
    PLATFORM_BLACKBERRY => "Blackberry",
    PLATFORM_ANDROID => "Android",
    PLATFORM_WINDOWS => "Windows Mobile",
}

# Apps categories
CAT_BROWSERS = 100
CAT_GAMES = 200
CAT_UTILITY = 300
CAT_OFFICE = 400
CAT_ENTERTAINMENT = 500
CAT_NEWS_AND_READER = 600
CAT_MESSAGING_TOOLS = 700
CAT_SOCIAL_NETWORKING = 800
CAT_MAPS = 900
CAT_MISCELLANEOUS = 1000

CAT_NAMES = {
    CAT_BROWSERS => "Browsers",
    CAT_GAMES => "Games",
    CAT_UTILITY => "Utility",
    CAT_OFFICE => "Office",
    CAT_ENTERTAINMENT => "Entertainment",
    CAT_NEWS_AND_READER => "News and Readers",
    CAT_MESSAGING_TOOLS => "Messaging Tools",
    CAT_SOCIAL_NETWORKING => "Social Networking",
    CAT_MAPS => "Maps",
    CAT_MISCELLANEOUS => "Miscellaneous"
}



# App status
APP_REJECTED = -10
APP_UPLOADED = 0
APP_FOR_USER_ONLY = 5
APP_FOR_PUBLIC = 10

UPLOAED_APP_STATUS_STR = {
    APP_REJECTED => "Rejected",
    APP_UPLOADED => "Uploaded, Review awaited",
    APP_FOR_USER_ONLY => "Accepted for your use only",
    APP_FOR_PUBLIC => "Accepted for public view",
  }


  # App type
  APP_ADMIN_UPLOADED = 0
  APP_USER_UPLOADED = 10
  APP_USER_SHARED = 20

  APP_TYPE_STR = {
    APP_ADMIN_UPLOADED => "Uploaded by admin",
    APP_USER_UPLOADED => "Uploaded by user",
    APP_USER_SHARED => "Shared by user",
  }


# set pagination size
 def self.per_page
    30
 end

 def self.save(upload,dir,id)
    if((dir == "JADs") || (dir == "JARs"))
    name = upload['datafile'].original_filename
    else
    timetoken = Time.now.to_s.gsub(/ /,'').gsub(/:/,'').tr("+","")
    name =  timetoken+upload['datafile'].original_filename
    end

    directory = "public/killer_downloads/killermobi/"+dir.to_s
    dir_to_store = "killer_downloads/killermobi/"+dir.to_s
    # create the file path
    path = File.join(directory, name)
    path_to_store = File.join(dir_to_store, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }

    @download = Download.find(id)
    if(dir == "JARs")
        @download.update_attribute(:file1url,path_to_store)
    elsif(dir == "JADs")
        @download.update_attribute(:file2url,path_to_store)
    elsif(dir == "ScreenShot1")
        @download.update_attribute(:ss1url,path_to_store)
    elsif(dir == "ScreenShot2")
        @download.update_attribute(:ss2url,path_to_store)
    elsif(dir == "ScreenShot3")
        @download.update_attribute(:ss3url,path_to_store)
    else
    end

  end

 def self.move_file(read_url,write_url)
   require 'fileutils'
   FileUtils.mv(read_url,write_url)
 end

 def sanitize_filename(file_name)
  # get only the filename, not the whole path (from IE)
  just_filename = File.basename(file_name)
  # replace all none alphanumeric, underscore or perioids
  # with underscore
  just_filename.sub(/[^\w\.\-]/,'_')
 end

 ###################################################################
 # Methods for scheduled task
 def self.update_daily_count
   downloads = Download.find(:all)
   for d in downloads
     d.update_attribute(:day_count, 0)
     d.save
     d.reload
   end
 end

 def self.update_weekly_count
   downloads = Download.find(:all)
   for d in downloads
     d.update_attribute(:week_count, 0)
     d.save
     d.reload
   end
 end

 def self.update_monthly_count
   downloads = Download.find(:all)
   for d in downloads
     d.update_attribute(:month_count, 0)
     d.save
     d.reload
   end
 end

 def self.add_files_dd(path, download)
   if(Util.none(download.file1url))
     if(Util.none(download.file2url))
       # Do Nothing
     else
       download.file2url = path
     end
   else
     download.file1url = path
   end
   return download
 end

 def self.add_screenshot_dd(path, download)
   if(Util.none(download.ss1url))
     if(Util.none(download.ss2url))
       if(Util.none(download.ss3url))
         if(Util.none(download.ss4url))
           if(Util.none(download.ss5url))
             if(Util.none(download.ss6url))
               if(Util.none(download.more_ss))
                 ss = download.more_ss.split(":")
                 ss << path
                 download.more_ss = ss.join(":")
               else
                 download.more_ss = path
               end
             else
               download.ss6url = path
             end
           else
             download.ss5url = path
           end
         else
           download.ss4url = path
         end
       else
         download.ss3url = path
       end
     else
       download.ss2url = path
     end
   else
     download.ss1url = path

     rr = "public#{path}"
     a_new_path = path.split("/")
     a_new_path.delete(a_new_path.last)
     new_path = "public/#{a_new_path.join('/')}/"
     ww = new_path+download.title.tr(" ","_")+"_killermobi_170x190.gif"
     ww1 = new_path+download.title.tr(" ","_")+"_killermobi_145x165.gif"
     ww2 = new_path+download.title.tr(" ","_")+"_killermobi_100x120.gif"
     ww3 = new_path+download.title.tr(" ","_")+"_killermobi_60x80.gif"

     download.ss1url = "#{a_new_path.join('/')}/"+download.title.tr(" ","_")+"_killermobi_170x190.gif"
     download.ss1_medium = "#{a_new_path.join('/')}/"+download.title.tr(" ","_")+"_killermobi_145x165.gif"
     download.ss1_small = "#{a_new_path.join('/')}/"+download.title.tr(" ","_")+"_killermobi_100x120.gif"
     download.ss1_thumb = "#{a_new_path.join('/')}/"+download.title.tr(" ","_")+"_killermobi_60x80.gif"
     begin
       system("#{User.convert} #{rr} -resize 170x190 #{ww}")
       system("#{User.convert} #{rr} -resize 145x165 #{ww1}")
       system("#{User.convert} #{rr} -resize 100x120 #{ww2}")
       system("#{User.convert} #{rr} -resize 60x80 #{ww3}")
     rescue => e
       logger.info("\n\n\n\n#{e.to_s}\n\n\n\n")
     end
   end
   return download
 end

end
