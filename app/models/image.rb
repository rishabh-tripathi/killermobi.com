class Image < ActiveRecord::Base
  OBJ_TYPE_DOWNLOAD = 10

  STATUS_VALID = 10
  STATUS_DELETED = -10

  def self.save_image(obj_type, obj_id, name, status, base_name, base_image_url)
    image = Image.new
    image.obj_type = obj_type
    image.obj_id = obj_id
    image.name = name
    image.status = status

    rr = base_image_url
    ww = "public/killer_downloads/images/base/"+base_name.tr(" ","_")+"_killermobi_170x190.gif"
    ww1 = "public/killer_downloads/images/medium/"+base_name.tr(" ","_")+"_killermobi_145x165.gif"
    ww2 = "public/killer_downloads/images/small/"+base_name.tr(" ","_")+"_killermobi_100x120.gif"
    ww3 = "public/killer_downloads/images/thumb/"+base_name.tr(" ","_")+"_killermobi_60x80.gif"

    image.image_base = "/killer_downloads/images/base/"+base_name.tr(" ","_")+"_killermobi_170x190.gif"
    image.image_medium = "/killer_downloads/images/medium/"+base_name.tr(" ","_")+"_killermobi_145x165.gif"
    image.image_small = "/killer_downloads/images/small/"+base_name.tr(" ","_")+"_killermobi_100x120.gif"
    image.image_thumb = "/killer_downloads/images/thumb/"+base_name.tr(" ","_")+"_killermobi_60x80.gif"
    error = false
    begin
      system("#{Image.convert} #{rr} -resize 170x190 #{ww}")
      system("#{Image.convert} #{rr} -resize 145x165 #{ww1}")
      system("#{Image.convert} #{rr} -resize 100x120 #{ww2}")
      system("#{Image.convert} #{rr} -resize 60x80 #{ww3}")
    rescue => e
      msg = msg+"Problem in converting image and moving (#{e.to_s})"
      error = true
    end
    if(!error)
      if(image.save)
        return image
      else
        return nil
      end
    else
      return nil
    end
  end

  def self.convert
    if ENV["OS"] =~ /Windows/
      # Set this to point to the right Windows directory for ImageMagick.
      "C:\\Program Files\\ImageMagick-6.7.0-Q16\\convert"
    else
      "/usr/bin/convert"
    end
  end


  # migration
  def self.migrate_download_images
    all_downloads = Download.find(:all)
    for a in all_downloads
      ss1img = Image.save_image(OBJ_TYPE_DOWNLOAD, a.id, "download_base", STATUS_VALID, "#{a.title.tr(' ','-')}-#{a.id}", "public/#{a.ss1url}")
      if(!ss1img.nil?)
        puts "ss1 success"
      else
        puts "ss1 failed"
      end
      ss2img = Image.save_image(OBJ_TYPE_DOWNLOAD, a.id, "download_ss", STATUS_VALID, "#{a.title.tr(' ','-')}-#{a.id}", "public/#{a.ss2url}")
      if(!ss2img.nil?)
        puts "ss2 success"
      else
        puts "ss2 failed"
      end
      ss3img = Image.save_image(OBJ_TYPE_DOWNLOAD, a.id, "download_ss", STATUS_VALID, "#{a.title.tr(' ','-')}-#{a.id}", "public/#{a.ss3url}")
      if(!ss3img.nil?)
        puts "ss3 success"
      else
        puts "ss3 failed"
      end
    end
  end

end
