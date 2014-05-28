require 'digest/sha2'
require 'rss/2.0'
class User < ActiveRecord::Base
  has_many :authentications
  # Include default devise modules. Others available are:
  #  :confirmable, :encryptable and :omniauthable
  devise :database_authenticatable, :lockable, :recoverable, :encryptable,
         :rememberable, :registerable, :trackable, :timeoutable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_one :user_detail
  has_many :articles
  has_many :entries
  has_many :comments
  has_many :friendships
  has_many :friends, :through => :friendships, :class_name => 'User'
  has_and_belongs_to_many :roles

  def apply_omniauth(omniauth)
    token = ""
    token = omniauth['credentials']['token'] if(!omniauth['credentials'].nil? && !omniauth['credentials'].empty? && !omniauth['credentials']['token'].nil? && !omniauth['credentials']['token'].empty?)
    auth = authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :access_token => token)
    return auth
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def has_role?(rolename)
    self.roles.find_by_name(rolename) ? true : false
  end

  def email_with_username
    "#{username} <#{email}>"
  end

  def self.convert
    if ENV["OS"] =~ /Windows/
      # Set this to point to the right Windows directory for ImageMagick.
      "C:\\Program Files\\ImageMagick-6.7.0-Q16\\convert"
    else
      "/usr/bin/convert"
    end
  end


  def self.save_all_mobimates(user_id)
    user = User.find(user_id)
    mobimates = search_all_mobimates(user)
    mobimates_id = []
    for m in mobimates
      mobimates_id << m.id
    end
    user.mobimates = mobimates_id.join(":")
    user.mobimate_count = mobimates.size
    user.save(:validate => false)
    return mobimates
  end

  def self.search_all_mobimates(user)
    User.find(:all, :conditions => "id != #{user.id} and handset like '#{user.handset}'")
  end

  def get_virtual_device
    VirtualDevice.find_by_user_id(id)
  end

  def get_real_devices
    RealDevice.find(:all, :conditions => "user_id = #{id}")
  end

  def get_all_access_tokens
    devices = get_real_devices
    tokens = []
    for d in devices
      tokens << d.access_tokens
    end
  end
end
