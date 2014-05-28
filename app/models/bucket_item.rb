class BucketItem < ActiveRecord::Base
  belongs_to :bucket

  OBJ_TYPE_APP = 10
  OBJ_TYPE_FILE = 20

  # Status
  STATUS_NEW = 10

  # Access
  ACCESS_PRIVATE = 10
  ACCESS_PUBLIC = 0

  def self.add_item_to_bucket(bucket, obj_type, obj_id)
    item = BucketItem.new
    item.bucket_id = bucket.id
    item.obj_type = obj_type
    item.obj_id = obj_id
    item.status = STATUS_NEW
    item.access = ACCESS_PUBLIC
    if(obj_type == OBJ_TYPE_FILE)
      file_access = UploadedFile.find(obj_id).access
      if(file_access == UploadedFile::ACCESS_PRIVATE)
        item.access = ACCESS_PRIVATE
        if(bucket.access == Bucket::ACCESS_PUBLIC)
          bucket.update_attribute(:access, Bucket::ACCESS_PRIVATE)
        end
      end
    end
    item.save
    return item
  end

  def item_name
    name = nil
    if(self.obj_type == OBJ_TYPE_APP)
      name = Download.find(self.obj_id).title
    elsif(self.obj_type == OBJ_TYPE_FILE)
      name = UploadedFile.find(self.obj_id).file_name
    end
    return name
  end

  def item_path
    path = []
    if(self.obj_type == OBJ_TYPE_APP)
      app = Download.find(self.obj_id)
      path << app.file1url if(!app.file1url.nil? && !app.file1url.empty?)
      # path << app.file2url if(!app.file2url.nil? && !app.file2url.empty?)
    elsif(self.obj_type == OBJ_TYPE_FILE)
      file = UploadedFile.find(self.obj_id)
      path << file.get_local_path
    end
    return path
  end

  def item_image_path
    path = []
    if(self.obj_type == OBJ_TYPE_APP)
      if(self.obj_id > 0)
        app = Download.find(self.obj_id)
        path << app.ss1url if(Util.none(app.ss1url))
        # will add other images like medium, large or other screen shots when needed
      end
    end
    if(self.obj_type == OBJ_TYPE_FILE)
      if(self.obj_id > 0)
        app = UploadedFile.find(self.obj_id)
        path << app.thumb_image if(Util.none(app.thumb_image))
      end
    end
    return path
  end

end
