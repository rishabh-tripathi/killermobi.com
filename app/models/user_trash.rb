class UserTrash < ActiveRecord::Base

  OBJ_MESSAGE = 10
  OBJ_CONTACT = 20
  OBJ_FILE = 30


  def self.trash_item(obj_id, obj_type, user, device)
    trash = UserTrash.new(:obj_id => obj_id, :obj_type => obj_type, :user_id => user.id, :device_id => device.id)
    trash.save
  end


end

