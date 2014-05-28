class Review < ActiveRecord::Base

  OBJ_TYPE_APP = 10
  OBJ_TYPE_BUCKET = 20

  def self.search_for_obj(obj_type, obj_id, order = "created_at desc")
    return Review.find(:all, :conditions => ["obj_type = ? and obj_id = ?", obj_type, obj_id], :order => order)
  end
end
