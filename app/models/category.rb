class Category < ActiveRecord::Base
has_many :articles, :dependent => :nullify
self.inheritance_column = ''
validates_length_of :name, :maximum => 80

end
