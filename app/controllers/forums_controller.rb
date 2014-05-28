class ForumsController < ApplicationController
before_filter :set_title
before_filter :check_administrator_role, :except => [:index, :show]

def set_title
@title = "Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Software"
end
  # GET /forums
  # GET /forums.xml
  def index
    @forums = Forum.find(:all)

    @title = "Mobile Forums - Smartphone Forums - Post your queries - KillerMobi Forums"
    @keywords = "mobile forum,mobile freeware,smartphone mobile,mobile smartphones,mobile unlocking,mobile upgrade,mobile forums,smartphone forums,smart phone mobile,software forums"
    @page_desc = "Post your problems in KillerMobi Forum and get quick solution. Mobile forum, Nokia forum, Samsung forum, Sony Erricson forum, Motorola Forum, Technical forum, mobile developement forum."
    # @tags = Post.tag_counts
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forums }
    end
  end

  # GET /forums/1
  # GET /forums/1.xml

def show
    @title = "Mobile Forums - Smartphone Forums - Post your queries - KillerMobi Forums"
    @keywords = "mobile forum,mobile freeware,smartphone mobile,mobile smartphones,mobile unlocking,mobile upgrade,mobile forums,smartphone forums,smart phone mobile,software forums"
    @page_desc = "Post your problems in KillerMobi Forum and get quick solution. Mobile forum, Nokia forum, Samsung forum, Sony Erricson forum, Motorola Forum, Technical forum, mobile developement forum."

redirect_to topics_path(:forum_id => params[:id])
end

  # GET /forums/new
  # GET /forums/new.xml
  def new
    @forum = Forum.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum }
    end
  end

  # GET /forums/1/edit
  def edit
    @forum = Forum.find(params[:id])
  end

  # POST /forums
  # POST /forums.xml
  def create
    @forum = Forum.new(params[:forum])

    respond_to do |format|
      if @forum.save
        flash[:notice] = 'Forum was successfully created.'
        format.html { redirect_to forums_path }
        format.xml  { render :xml => @forum, :status => :created, :location => @forum }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /forums/1
  # PUT /forums/1.xml
  def update
    @forum = Forum.find(params[:id])

    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        flash[:notice] = 'Forum was successfully updated.'
        format.html { redirect_to(@forum) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.xml
  def destroy
    @forum = Forum.find(params[:id])
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to(forums_url) }
      format.xml  { head :ok }
    end
  end
end
