class Bucket < ActiveRecord::Base
  has_many :bucket_item

  # Status
  STATUS_NEW = 10
  STATUS_DELETED = -100

  # Access
  ACCESS_PRIVATE = 10
  ACCESS_PUBLIC = 0

  # set pagination size
  def self.per_page
    6
  end

  def self.create_empty_bucket(name, user)
    bucket = Bucket.new
    bucket.name = name
    bucket.user_id = user.id
    bucket.status = Bucket::STATUS_NEW
    bucket.access = Bucket::ACCESS_PRIVATE
    bucket.save
    user.update_attribute(:current_bucket, bucket.id)
    return bucket
  end

  def self.search_bucket(id)
    bucket = Bucket.find(id)
    bucket_item = bucket.bucket_item if(!bucket.nil?)
    return [bucket, bucket_item]
  end

  def self.search_bucket_by_name(name)
    bucket = Bucket.find_by_name(name)
    bucket_item = bucket.bucket_item if(!bucket.nil?)
    return [bucket, bucket_item]
  end

  def self.search_by_download_id(id)
    return Bucket.find_by_download_id(id)
  end

  def self.user_current_bucket(user)
    bucket = nil
    bucket_item = nil
    if(user.current_bucket > 0)
      (bucket, bucket_item) = Bucket.search_bucket(user.current_bucket)
    end
    return [bucket, bucket_item]
  end

  def self.search_all_user_buckets(user, limit = 5, order = "created_at desc")
    return Bucket.find(:all, :conditions => ["user_id = ?", user.id], :order => order, :limit => limit)
  end

  def get_bucket_images_array
    bucket_item = self.bucket_item
    img_array = []
    if(Util.none(bucket_item))
      for item in bucket_item
        img_array << item.item_image_path
      end
    else
      img_array << "/images/v2/empty_bucket.png"
    end
    return img_array
  end

end
