class ArticlesController < ApplicationController

before_filter :check_administrator_role, :except => [:index, :show, :article_to_review, :create_article_to_review, :remote_tag_edit, :remote_tag_update, :tag_page_show]
before_filter :check_editor_role, :only => [:article_to_review, :create_article_to_review]
before_filter :login_required, :only => [:article_to_review, :create_article_to_review, :remote_tag_edit, :remote_tag_update]

def index
@title = "Mobile Articles - Mobile Technology Articles - Mobile Development Articles - Articles On KillerMobi"
@keywords = "mobile articles,mobile software articles,mobile new technologies articles,mobile development articles"
@page_desc = "Read new trands of mobile technology in KillerMobi Articles. Mobile Articles, Mobile Software Articles, New technologies articles, mobile development articles.",
@articles = nil
if params[:category_name]
title = params[:category_name].tr("_"," ")
@cat = Category.find_by_name(title)
@articles = Article.paginate(:page => params[:page], :conditions => "category_id=#{@cat.id} AND published=true", :order => 'published_at DESC', :include => :user)
@category = Category.find(:all)
else
@articles = Article.paginate(:page => params[:page], :conditions => "published=true", :order => 'published_at DESC', :include => :user)
@category = Category.find(:all)
end
# @tags = Article.tag_counts
respond_to do |wants|
wants.html
wants.xml { render :xml => @articles.to_xml }
end
end

def show
title = params[:title].tr("_"," ")
if is_logged_in? && @logged_in_user.has_role?('Administrator')
@article = Article.find_by_title(title)
else
@article = Article.find_by_title_and_published(title, true)
end

# @tags = @article.tag_counts

@title = "#{@article.title} - Mobile Articles - Mobile Technology Articles - Mobile Development Articles - KillerMobi"
@keywords = "mobile articles,mobile software articles,mobile new technologies articles,mobile development articles"
@page_desc = "Read new trands of mobile technology in KillerMobi Articles. Mobile Articles, Mobile Software Articles, New technologies articles, mobile development articles.",

respond_to do |wants|
wants.html
wants.xml { render :xml => @article.to_xml }
end
end

def show_by_category
@article = Article.find(:all, :conditions => "category_id=#{params[:category_id].to_i} AND published=true", :order => 'published_at DESC')
end

def new
@article = Article.new
end
def create
@article = Article.create(params[:article])
@logged_in_user.articles << @article
respond_to do |wants|
wants.html { redirect_to admin_articles_url }
wants.xml { render :xml => @article.to_xml }
end
end

def edit
@article = Article.find(params[:id])
end

def update
@article = Article.find(params[:id])
@article.update_attributes(params[:article])
respond_to do |wants|
wants.html { redirect_to admin_articles_url }
wants.xml { render :xml => @article.to_xml }
end
end

def destroy
@article = Article.find(params[:id])
@article.destroy
respond_to do |wants|
wants.html { redirect_to admin_articles_url }
wants.xml { render :nothing => true }
end
end

def admin
@articles = Article.find(:all, :order => 'published_at DESC')
#@articles_pages = @articles.paginate(:order => 'published_at DESC')
end

def article_to_review
@article = Article.new
end

def create_article_to_review
@article = Article.create(params[:article])
logger.info("\n\n\n\n\n#{@logged_in_user.id}\n\n\n\n");
@article.update_attribute(:user_id,@logged_in_user.id)
respond_to do |wants|
wants.html {
flash[:notice] = 'Article submitted successfully to Administrator. Waiting for review.'
redirect_to articles_url }
wants.xml { render :xml => @article.to_xml }
end
end

# Method to edit tags #######################################################################
def remote_tag_edit
if is_logged_in?
title = params[:title].tr("_"," ")
@article = Article.find_by_title(title)
render(:layout => false)
else
redirect_to login_url
end
end

def remote_tag_update
title = params[:title].tr("_"," ")
@article = Article.find_by_title(title)
if logged_in_user.has_role?('Administrator')
@article.tag_list = params[:article][:tag_list]
else
@article.tag_list.add(params[:article_tag][:new_tag])
end
if @article.save
@tags = @article.tag_counts
render(:partial => "show_tags")
else
render :text => "Error updating tags"
end
end

def tag_page_show
# @category = params[:tag] ||= ""
# @article = Article.find_tagged_with(@category)
# respond_to do |format|
# format.html #default
# format.xml { render :xml => @recipes}
# end
  redirect_to root_path
end
############################################################################################

end
