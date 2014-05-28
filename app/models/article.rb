class Article < ActiveRecord::Base
#acts_as_taggable
#before_save :save_cached_tag_list
belongs_to :user
belongs_to :category
self.inheritance_column = ''

validates_presence_of :title
validates_presence_of :synopsis
validates_presence_of :body
validates_presence_of :title
validates_length_of :title, :maximum => 255
validates_length_of :synopsis, :maximum => 1000
validates_length_of :body, :maximum => 20000

before_save :update_published_at
def update_published_at
self.published_at = Time.now if published == true
end

def self.per_page
    50
  end

#@articles_pages = Article.paginate :page => 1, :order => 'created_at DESC', :conditions => "published=true"

end
