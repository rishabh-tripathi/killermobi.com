class Util < ActiveRecord::Base

  def self.random_alphanumeric(size = 6)
    s = ""
    size.times { s << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
    return s
  end

  def self.none(obj)
    state = false
    if(obj.class == Array || obj.class == Hash || obj.class == String)
      state = (!obj.nil? && !obj.empty?)
    else
      state = !obj.nil?
    end
    return state
  end

end
