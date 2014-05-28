class SpamId < ActiveRecord::Base

def self.generate
  for a in (1..50)
    @code = rand(10 ** 10).to_s.rjust(10,'0')
    @spam_id = SpamId.new(:code=>@code)
    @spam_id.save
  end  
end

def self.get_random_spam_id
  all_ids = SpamId.find(:all)
  all_ids_str = []
  for all in all_ids
    all_ids_str << all.code
  end
  return all_ids_str[rand(50)]
end

def self.check_spam_id(id)
  found = false
  all_ids = SpamId.find(:all)
  for all in all_ids
    if(all.code == id)
      found = true
    end
  end
  return found
end

end
