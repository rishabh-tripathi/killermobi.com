class Worldcup2011Controller < ApplicationController
require 'rss/2.0'

  # GET /worldcup2011s
  # GET /worldcup2011s.xml
  def index
    @worldcup2011s = Worldcup2011.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @worldcup2011s }
      format.rss { render :xml => @worldcup2011s.to_rss_feed("World Cup 2011","KillerMobi.com", "Comment for user")}
    end
  end

  def commentRSS
  @comment = Worldcup2011.find(:all, :order => "id DESC", :limit => 10)
  render :layout => false
  response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end


 def add_mobile
    name = params[:name].tr("_"," ")
    on = params[:on].tr("_"," ")
    comment = params[:comment].tr("_"," ")    

    if((!name.nil?) && (!on.nil?) && (!comment.nil?))
    @wc_comment = Worldcup2011.new(:name=>name,:on=>on,:comment=>comment)
    	
    if @wc_comment.save
    render :text=>"Comment Submitted Sucessfully."
    else
    render :text=>"Error in submission"
    end

    else
    render :text=>"Comment no submitted. Please specify the full details."
    end
  end


  # GET /worldcup2011s/new
  # GET /worldcup2011s/new.xml
  def new
    @worldcup2011 = Worldcup2011.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @worldcup2011 }
    end
  end

  # GET /worldcup2011s/1/edit
  def edit
    @worldcup2011 = Worldcup2011.find(params[:id])
  end

  # POST /worldcup2011s
  # POST /worldcup2011s.xml
  def create
    @worldcup2011 = Worldcup2011.new(params[:worldcup2011])

    respond_to do |format|
      if @worldcup2011.save
        flash[:notice] = 'Worldcup2011 was successfully created.'
        format.html { redirect_to wc_home_url }
      else
        format.html { render wc_new_comment_url }
      end
    end
  end

  # PUT /worldcup2011s/1
  # PUT /worldcup2011s/1.xml
  def update
    @worldcup2011 = Worldcup2011.find(params[:id])

    respond_to do |format|
      if @worldcup2011.update_attributes(params[:worldcup2011])
        flash[:notice] = 'Worldcup2011 was successfully updated.'
        format.html { redirect_to wc_home_url }
      else
        format.html { render wc_edit_comment_url(@worldcup2011.id) }
      end
    end
  end

  # DELETE /worldcup2011s/1
  # DELETE /worldcup2011s/1.xml
  def destroy
    @worldcup2011 = Worldcup2011.find(params[:id])
    @worldcup2011.destroy

    respond_to do |format|
      format.html { redirect_to wc_home_url }
    end
  end
end

def to_rss_feed(title, link, description="")
rss = RSS::Rss.new("2.0")
channel = RSS::Rss::Channel.new
rss.channel = channel
channel.title = title
channel.link = link
channel.description = description
self.each do |item|
channel.items << item.to_rss_item
end
rss.to_s
end

def to_rss_item
returning RSS::Rss::Channel::Item.new do |item|
item.title = title
item.link = "http://localhost:3000/recipes/#{id}"
item.description = content
item.author = user.email
item.pubDate = created_at
item.guid = RSS::Rss::Channel::Item::Guid.new
end
end
