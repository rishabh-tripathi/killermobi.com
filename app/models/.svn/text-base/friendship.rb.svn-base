class Friendship < ActiveRecord::Base
belongs_to :user
belongs_to :friend, :class_name => 'User', :foreign_key => 'friend_id'
self.inheritance_column = ''

STATUS_BLOCKED = -200
STATUS_REJECTED = -100
STATUS_REQUESTED = 100
STATUS_AWAITED = 200
STATUS_ACCEPTED = 300

FRIENDSHIP_STATUS = {
    STATUS_BLOCKED => "Blocked",
    STATUS_REJECTED => "Rejected",
    STATUS_REQUESTED => "Requested",
    STATUS_AWAITED => "Awaited",
    STATUS_ACCEPTED => "Accepted",
  }

TYPE_FRIENDSHIP = 100
TYPE_PHYSICAL = 200
TYPE_PROFESSIONAL = 300
TYPE_GEOGRAPHICAL = 400
TYPE_FAMILY = 500
TYPE_ROMANTIC = 600

FRIEND_CAT = {
    TYPE_FRIENDSHIP => "Friendship",
    TYPE_PHYSICAL => "Physical",
    TYPE_PROFESSIONAL => "Professional",
    TYPE_GEOGRAPHICAL => "Geographical",
    TYPE_FAMILY => "Family",
    TYPE_ROMANTIC => "Romantic",
  }


CONTACT = 110
ACQUAINTANCE = 120
FRIEND = 130
MET = 210
COWORKER = 310
COLLEAGUE = 320
CLASSMATE = 330
CO_RESIDENT = 410
NEIGHBOR = 420
CHILD = 510
PARENT = 520
SIBLING = 530
SPOUSE = 540
KIN = 550
MUSE = 610
CRUSH = 620
DATE = 630
SWEETHEART = 640

FRIEND_TYPE = {
    CONTACT => "Contact",
    ACQUAINTANCE => "Acquaintance",
    FRIEND => "Friend",
    MET => "Met",
    COWORKER => "Co worker",
    COLLEAGUE => "Colleague",
    CLASSMATE => "Classmate",
    CO_RESIDENT => "Co resident",
    NEIGHBOR => "Neighbor",
    CHILD => "Child",
    PARENT => "Parent",
    SIBLING => "Sibling",
    SPOUSE => "Spouse",
    KIN => "Kin",
    MUSE => "Muse",
    CRUSH => "Crush",
    DATE => "Date",
    SWEETHEART => "Sweetheart"
  }

  def self.users_from_friendship(friendship)
    friend_ids = []
    for f in friendship
      friend_ids << f.friend_id
    end
    friend_ids_str = friend_ids.join(",")
    friends = User.find(:all, :conditions => "id in (#{friend_ids_str})")
    return friends
  end


  def self.add_friendship(user_id, friend_id, type = nil, type_id = nil)
    u = Friendship.new
    u.user_id = user_id
    u.friend_id = friend_id
    u.status = STATUS_REQUESTED
    u.type = type if(!type.nil?)
    u.type_id = type_id if(!type_id.nil?)
    u.created_at = Time.now
    u.save
    f = Friendship.new
    f.user_id = friend_id
    f.friend_id = user_id
    f.status = STATUS_AWAITED
    f.created_at = Time.now
    f.save
  end

  def self.accept_friendship(user_id, friend_id, type = nil, type_id = nil)
    u = Friendship.find(:first, :conditions =>"user_id = #{user_id} and friend_id = #{friend_id}")
    f = Friendship.find(:first, :conditions =>"user_id = #{friend_id} and friend_id = #{user_id}")
    u.status = STATUS_ACCEPTED
    u.type = type if(!type.nil?)
    u.type_id = type_id if(!type_id.nil?)
    u.accepted_at = Time.now
    u.updated_at = Time.now
    u.save
    f.status = STATUS_ACCEPTED
    f.accepted_at = Time.now
    f.updated_at = Time.now
    f.save
  end

  def self.reject_friendship(user_id, friend_id)
    u = Friendship.find(:first, :conditions =>"user_id = #{user_id} and friend_id = #{friend_id}")
    f = Friendship.find(:first, :conditions =>"user_id = #{friend_id} and friend_id = #{user_id}")
    u.status = STATUS_REJECTED
    u.updated_at = Time.now
    u.save
    f.status = STATUS_REJECTED
    f.updated_at = Time.now
    f.save
  end

  def self.is_my_friend?(user, friend_id)
    friendship = Friendship.find(:first, :conditions => "user_id = #{user.id} and friend_id = #{friend_id}")
    return !friendship.nil?
  end


  def self.search_friend_request(user_id)
    friendship = Friendship.find(:all, :conditions => "user_id = #{user_id} and status = #{Friendship::STATUS_AWAITED}", :limit => 6)
    friends = nil
    friends = Friendship.users_from_friendship(friendship) if(!friendship.nil? && !friendship.empty?)
    return friends
  end

  def self.search_all_friends(user_id, status = nil, type = nil, type_id = nil)
    query = "user_id = #{user_id}"
    query += " and status = #{STATUS_ACCEPTED}" if(!status.nil?)
    query += " and type = #{type}" if(!type.nil?)
    query += " and type_id = #{type_id}" if(!type_id.nil?)
    friendship = Friendship.find(:all, :conditions => query)
    friends = nil
    friends = Friendship.users_from_friendship(friendship) if(!friendship.nil? && !friendship.empty?)
    if(!friends.nil? && !friends.empty?)
      user = User.find(user_id)
      user.friends_count = friends.size
      user.save(:validate => false)
    end
    return friends
  end

  def self.remove_friendship(user_id, friend_id)
    u = Friendship.find(:first, :conditions =>"user_id = #{user_id} and friend_id = #{friend_id}")
    f = Friendship.find(:first, :conditions =>"user_id = #{friend_id} and friend_id = #{user_id}")
    u.destroy
    f.destroy
  end
end
