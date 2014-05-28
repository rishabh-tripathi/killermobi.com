class UploadedFile < ActiveRecord::Base

  DELETED = -100

  # Storage
  STORAGE_KM = 0
  STORAGE_DROPBOX = 10

  STORAGE_NAMES = {
    STORAGE_KM => "KillerMobi",
    STORAGE_DROPBOX => "Dropbox",
  }

  # File types
  FILE_TYPE_UNKNOWN = 0
  FILE_TYPE_JPEG = 100
  FILE_TYPE_PNG = 110
  FILE_TYPE_GIF = 120
  FILE_TYPE_BMP = 130
  FILE_TYPE_MP3 = 200
  FILE_TYPE_MPEG = 300
  FILE_TYPE_AVI = 310
  FILE_TYPE_3GP = 320
  FILE_TYPE_PDF = 400
  FILE_TYPE_DOC = 410
  FILE_TYPE_XLS = 420
  FILE_TYPE_TXT = 430
  FILE_TYPE_ZIP = 440

  FILE_TYPE_EXT = {
    FILE_TYPE_UNKNOWN => "unknown",
    FILE_TYPE_JPEG => "jpg",
    FILE_TYPE_PNG => "png",
    FILE_TYPE_GIF => "gif",
    FILE_TYPE_BMP => "bmp",
    FILE_TYPE_MP3 => "mp3",
    FILE_TYPE_MPEG => "mpeg, mpg",
    FILE_TYPE_AVI => "avi",
    FILE_TYPE_3GP => "3gp",
    FILE_TYPE_PDF => "pdf",
    FILE_TYPE_DOC => "doc docx",
    FILE_TYPE_XLS => "xls",
    FILE_TYPE_TXT => "txt csv",
    FILE_TYPE_ZIP => "zip",
  }

  # File category
  FILE_CAT_IMAGE = 100
  FILE_CAT_MUSIC = 200
  FILE_CAT_VIDEO = 300
  FILE_CAT_FILES = 400

  FILE_CAT_NAMES = {
    FILE_CAT_IMAGE => "Image",
    FILE_CAT_MUSIC => "Music",
    FILE_CAT_VIDEO => "Video",
    FILE_CAT_FILES => "Other files",
  }

  FILE_CAT_DEFAULT_THUMB = {
    FILE_CAT_IMAGE => "/images/v2/image.jpg",
    FILE_CAT_MUSIC => "/images/v2/music.png",
    FILE_CAT_VIDEO => "/images/v2/video.png",
    FILE_CAT_FILES => "/images/v2/files.png",
  }

  # Access
  ACCESS_PRIVATE = 100
  ACCESS_PUBLIC = 200

  ACCESS_NAMES = {
    ACCESS_PRIVATE => "Private",
    ACCESS_PUBLIC => "Public",
  }

  # Directory
  IS_FILE = 100
  IS_DIR = 200


  def get_thumb_image
    thumb_image = self.thumb_image
    if(thumb_image.nil? || thumb_image.empty?)
      thumb_image = UploadedFile::FILE_CAT_DEFAULT_THUMB[self.file_cat]
    end
    return thumb_image
  end

  def get_local_path
    path = ""
    if(self.storage == STORAGE_DROPBOX)
      if(!(File.exist?("./tmp/user_dropbox_files/#{self.user_id}/#{self.file_name}")))
        ud = UserDetail.find_by_user_id(self.user_id)
        dbsession = DropboxSession.deserialize(ud.dropbox_session)
        client = DropboxClient.new(dbsession, :app_folder)
        path = "./tmp/user_dropbox_files/#{self.user_id}"
        FileUtils.mkdir_p(path)
        local_file = File.new("#{RAILS_ROOT}/tmp/user_dropbox_files/#{self.user_id}/#{self.file_name}", 'wb')
        out = client.get_file(self.file_path)
        local_file.write(out)
        local_file.close
      end
      path = "./tmp/user_dropbox_files/#{self.user_id}/#{self.file_name}"
    else
      path = "./#{self.file_path}"
    end
    return path
  end

  def self.get_file_type(file_name)
    type = FILE_TYPE_UNKNOWN
    ext = file_name.split(".").last
    FILE_TYPE_EXT.each do|key, value|
      if(value.include? ext)
        type = key
        break
      end
    end
    return type
  end

  def self.get_file_category(file_type)
    cat = 0
    type = file_type
    if(type > 0)
      cat = (type/100) * 100
    else
      cat = FILE_CAT_FILES
    end
    return cat
  end

  def self.search_files(user, cat, order = "created_at desc")
    if(user.class == Fixnum)
      uid = user
    else
      uid = user.id
    end
    files = UploadedFile.find(:all, :conditions => ["deleted = 0 and user_id = ? and file_cat = ?", uid, cat], :order => order)
    return files
  end

  def self.save_file(user, request=nil, param=nil)
    file = UploadedFile.new
    user_detail = user.user_detail
    storage = user.default_storage
    file.storage = storage
    (file_path, file_name, file_type, file_size, thumb) = upload_file(request, param, user, storage)
    file.file_name = file_name
    file.file_path = file_path
    file.file_type = UploadedFile.get_file_type(file.file_name)
    file.user_id = user.id
    file.file_size = file_size
    file.file_cat = UploadedFile.get_file_category(file.file_type)
    file.access = ACCESS_PRIVATE
    file.thumb_image = thumb
    file.token = Util.random_alphanumeric(30)
    file.save
  end

  ##############################################################################################
  # function called from uploader action location should be like "images/user_data"
  def self.upload_file(request = nil, params = nil, user = nil, dest = STORAGE_KM)
    status = true
    file_path = nil
    file_name = nil
    file_type_str = nil
    file_type = 0
    file_size = ""
    thumb = ""
    f_name = ""
    begin
      (f_name, file_name, file_type_str) = UploadedFile.dd_get_file_info(request, params)
      type = UploadedFile.get_file_type(f_name)
      cat = UploadedFile.get_file_category(type)
      file_type = type

      # mime_type = Mime::Type.lookup_by_extension(file_type_str)
      # content_type = mime_type.to_s unless mime_type.nil?
      # file_type = content_type

      if(dest == STORAGE_KM)
        new_file_name = file_name+"."+file_type_str
        path = "./user_data/#{user.id}/#{FILE_CAT_NAMES[cat]}"
        FileUtils.mkdir_p(path)
        file_loc = "#{RAILS_ROOT}/user_data/#{user.id}/#{FILE_CAT_NAMES[cat]}/#{new_file_name}"
        UploadedFile.dd_save_to_disk(file_loc, params, request)

      elsif(dest == STORAGE_DROPBOX)
        ud = user.user_detail
        dbsession = DropboxSession.deserialize(ud.dropbox_session)
        client = DropboxClient.new(dbsession, :app_folder)
        f_path = "/#{UploadedFile::FILE_CAT_NAMES[cat]}/#{f_name}"
        if(params.nil?)
          resp = client.put_file(f_path, Base64.decode64(request.body.read))
        else
          resp = client.put_file(f_path, params.read)
        end
        if(!resp.nil? && !resp.empty?)
          file_path = resp['path']
          file_size = resp['size']
          if(resp['thumb_exists'])
            t_path = "./public/user_data/upload/#{user.id}/dropbox_file_thumb"
            FileUtils.mkdir_p(t_path)
            thumb_file = File.new("#{RAILS_ROOT}/public/user_data/upload/#{user.id}/dropbox_file_thumb/#{file_name}_thumb.jpg", 'wb')
            out = client.thumbnail(file_path)
            thumb_file.write(out)
            thumb_file.close
            thumb = "/user_data/upload/#{user.id}/dropbox_file_thumb/#{file_name}_thumb.jpg"
          end
        end
      end
    rescue Exception => e
      logger.info("\n\n\n#{e.to_s}\n\n\n")
      status = false
    end
    if(status)
      if(dest != STORAGE_DROPBOX)
        file_path = "/user_data/#{user.id}/#{FILE_CAT_NAMES[cat]}/#{new_file_name}"
        if(cat == FILE_CAT_IMAGE)
          t_path = "./public/user_data/upload/#{user.id}/km_file_thumb"
          FileUtils.mkdir_p(t_path)
          rr = "user_data/#{user.id}/#{FILE_CAT_NAMES[cat]}/#{new_file_name}"
          ww = "public/user_data/upload/#{user.id}/km_file_thumb/#{file_name}_thumb.jpg"
          system("#{User.convert} #{rr} -resize 100x120 #{ww}")
          thumb = "/user_data/upload/#{user.id}/km_file_thumb/#{file_name}_thumb.jpg"
        end
      end
      file_name = f_name
    end
    return [file_path, file_name, file_type, file_size, thumb]
  end


  # Util methods
  # drag n drop save to disk
  def self.dd_save_to_disk(file_loc, params, request)
    pic = File.new(file_loc, "wb")
    if(params.nil? || params.empty?)
      pic.write Base64.decode64(request.body.read) # .gsub(/^(data:)[\w\W]+(;base64,)/,"")
    else
      pic.write params.read
    end
    pic.close
  end

  # file info from request and params
  def self.dd_get_file_info(request, params)
    if(!request.nil?)
      f_name = request.env['HTTP_X_FILE_NAME']
    else
      f_name = params.original_filename
    end

    f_name = f_name.tr(" ","_")
    file_name = f_name.gsub(".#{f_name.split('.').last}","")
    file_name = file_name.tr(".","_")
    file_name = file_name.tr(" ","_")
    file_type_str = f_name.split('.').last
    return [f_name, file_name, file_type_str]
  end
end
