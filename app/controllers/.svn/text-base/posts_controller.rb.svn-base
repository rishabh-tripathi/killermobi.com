class PostsController < ApplicationController
before_filter :check_administrator_role,
:only => [:destroy, :edit, :update]
before_filter :login_required, :except => [:index, :show, :tag_page_show]
  # GET /posts
  # GET /posts.xml
def index
@topic = Topic.find(params[:topic_id], :include => :forum)
@posts = Post.find(:all, :conditions => ['topic_id = ?', @topic.id])
@posts_pages = Post.find(:all, :conditions => ['topic_id = ?', @topic.id])
respond_to do |format|
format.html # index.rhtml
format.xml { render :xml => @posts.to_xml }
end
end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
def new
@topic = Topic.find(params[:topic_id], :include => :forum)
@post = Post.new
end

  # GET /posts/1/edit
 def edit
@post = Post.find(params[:id], :include => { :topic => :forum })
end

  # POST /posts
  # POST /posts.xml
def create
if(check_real_spam_id(params[:_user_auth_key]))
@topic = Topic.find(params[:topic_id])
@post = Post.new(:body => params[:body],
:topic_id => @topic.id,
:user_id => logged_in_user.id)
respond_to do |format|
if @post.save
flash[:notice] = 'Post was successfully created.'
format.html { redirect_to posts_path(:forum_id => @topic.forum_id,
:topic_id => @topic) }
format.xml { head :created, :location => post_path(@post) }
else
format.html { render :action => "new" }
format.xml { render :xml => @post.errors.to_xml }
end
end
else
  render(:text => "Could not submit post, Please try again later!")
end
end

  # PUT /posts/1
  # PUT /posts/1.xml
def update
@post = Post.find(params[:id])
respond_to do |format|
if @post.update_attributes(params[:post])
flash[:notice] = 'Post was successfully updated.'
format.html { redirect_to posts_path(
:forum_id => params[:forum_id],
:topic_id => params[:topic_id]) }
format.xml { head :ok }
else
format.html { render :action => "edit" }
format.xml { render :xml => @post.errors.to_xml }
end
end
end

  # DELETE /posts/1
  # DELETE /posts/1.xml
 def destroy
@post = Post.find(params[:id])
@post.destroy
respond_to do |format|
format.html { redirect_to posts_path(:forum_id => params[:forum_id],
:topic_id => params[:topic_id]) }
format.xml { head :ok }
end
end


# Method for tags ########################################################################
def tag_page_show
@category = params[:tag] ||= ""
@post = Post.find_tagged_with(@category)
respond_to do |format|
format.html #default
format.xml { render :xml => @recipes}
end
end
############################################################################################

end
