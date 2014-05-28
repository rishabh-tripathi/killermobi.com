class UserMessage < ActiveRecord::Base

  INBOX_MSG = 10
  OUTBOX_MSG = 20
  DRAFT_MSG = 30
  SAVED_MESSAGE = 40

  TRASHED = -10
  NOT_TRASHED = 0

  # read ###############################################################################################
  def self.all_message(user, device)
    condition_str = "user_id = #{user.id} and trashed = #{NOT_TRASHED}"
    condition_str += " and real_device_id = #{device.id}" if(!device.nil?)
    um = UserMessage.find(:all, :conditions => condition_str)
    return um
  end

  def self.all_inbox_msg(user, device)
    condition_str = "user_id = #{user.id} and message_type = #{INBOX_MSG} and trashed = #{NOT_TRASHED}"
    condition_str += " and real_device_id = #{device.id}" if(!device.nil?)
    um = UserMessage.find(:all, :conditions => condition_str)
    return um
  end

  def self.all_outbox_msg(user, device)
    condition_str = "user_id = #{user.id} and message_type = #{OUTBOX_MSG} and trashed = #{NOT_TRASHED}"
    condition_str += " and real_device_id = #{device.id}" if(!device.nil?)
    um = UserMessage.find(:all, :conditions => condition_str)
    return um
  end

  def self.all_draft_msg(user, device)
    condition_str = "user_id = #{user.id} and message_type = #{DRAFT_MSG} and trashed = #{NOT_TRASHED}"
    condition_str += " and real_device_id = #{device.id}" if(!device.nil?)
    um = UserMessage.find(:all, :conditions => condition_str)
    return um
  end
 ###############################################################################################

 # create  ###############################################################################################
  def self.save_inbox_msg(msg)
    msg.message_type = INBOX_MSG
    msg.save
  end

  def self.save_outbox_msg(msg)
    msg.message_type = OUTBOX_MSG
    msg.save
  end

  def self.save_draft_msg(msg)
    msg.message_type = DRAFT_MSG
    msg.save
  end

  def self.save_message(user_id, device_id, real_device_id, to, from, type, body, received_at = nil)
    msg = UserMessage.new
    msg.user_id = user_id
    msg.device_id = device_id
    msg.real_device_id = real_device_id
    msg.to = to
    msg.from = from
    msg.body = body
    msg.received_at = received_at
    if(type == INBOX_MSG)
      UserMessage.save_inbox_msg(msg)
    elsif(type == OUTBOX_MSG)
      UserMessage.save_outbox_msg(msg)
    elsif(type == DRAFT_MSG)
      UserMessage.save_draft_msg(msg)
    end
  end
  ###############################################################################################

  # write a message ########################################################################################
  def self.create_message(user, device, real_device, to, body)
    message = UserMessage.new
    message.user_id = user.id
    message.device_id = device.id
    message.real_device_id = real_device.id
    message.message_type = OUTBOX_MESSAGE
    message.to = to
    message.from = 00000
    message.body = body
    message.save
  end

  ###############################################################################################

  # delete  ###############################################################################################
  def self.delete_message(message, user, device)
    message.update_attribute(:trashed => TRASHED)
    UserTrash.trash_item(message.id, UserTrash::OBJ_MESSAGE, user, device)
  end
  ###############################################################################################

end
