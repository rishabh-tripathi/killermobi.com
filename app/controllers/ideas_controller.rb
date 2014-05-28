class IdeasController < ApplicationController
before_filter :set_title
before_filter :check_administrator_role, :except => [:index, :show, :new, :create]
before_filter :login_required, :except => [:index, :show, :new]


def set_title
@title = "Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Software"
end

  # GET /ideas
  # GET /ideas.xml
  def index
    @ideas = Idea.find(:all)

    @title = "Execute your ideas with KillerMobi - Develop Mobile Application - Execute Your Ideas - Killer Mobile Applications Idea"
    @keywords = "mobile application developers,mobile application developer,mobile app development,mobile applications development,j2me developer,mobile developers,mobile phone application development,j2me development,develop mobile application,mobile application developers,mobile application developer,mobile app development,mobile applications development,j2me developer,mobile developers,mobile phone application development,j2me development,develop mobile application,execute your ideas,killer mobile applications idea"
    @page_desc = "Execute your creativity with KillerMobi. Submit your Ideas to execute and get 30% of revenue after execution. mobile application development, killer mobile applications ideas, mobile software developments, develop mobile applications."

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ideas }
    end
  end

  # GET /ideas/1
  # GET /ideas/1.xml
  def show
    @idea = Idea.find(params[:id])
    @user = User.find(@idea.user_id)

    @title = "#{@idea.title} - Develop Mobile Application - Execute Your Ideas - Killer Mobile Applications Idea"
    @keywords = "mobile application developers,mobile application developer,mobile app development,mobile applications development,j2me developer,mobile developers,mobile phone application development,j2me development,develop mobile application,mobile application developers,mobile application developer,mobile app development,mobile applications development,j2me developer,mobile developers,mobile phone application development,j2me development,develop mobile application,execute your ideas,killer mobile applications idea"
    @page_desc = "Execute your creativity with KillerMobi. Submit your Ideas to execute and get 30% of revenue after execution. mobile application development, killer mobile applications ideas, mobile software developments, develop mobile applications."

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @idea }
    end
  end

  # GET /ideas/new
  # GET /ideas/new.xml
  def new
    @idea = Idea.new

    @title = "Execute your ideas with KillerMobi - Develop Mobile Application - Execute Your Ideas - Killer Mobile Applications Idea"
    @keywords = "mobile application developers,mobile application developer,mobile app development,mobile applications development,j2me developer,mobile developers,mobile phone application development,j2me development,develop mobile application,mobile application developers,mobile application developer,mobile app development,mobile applications development,j2me developer,mobile developers,mobile phone application development,j2me development,develop mobile application,execute your ideas,killer mobile applications idea"
    @page_desc = "Execute your creativity with KillerMobi. Submit your Ideas to execute and get 30% of revenue after execution. mobile application development, killer mobile applications ideas, mobile software developments, develop mobile applications."

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @idea }
    end
  end

  # GET /ideas/1/edit
  def edit
    @idea = Idea.find(params[:id])
  end

  # POST /ideas
  # POST /ideas.xml
  def create
    @idea = Idea.new(params[:idea])
    @user = logged_in_user
    respond_to do |format|
      if @idea.save
        @idea.update_attribute(:user_id,@user.id)
        if is_logged_in?
          UserMailer.after_idea_notification(logged_in_user).deliver
        end
        flash[:notice] = 'Idea was submitted successfully.'
        format.html { redirect_to root_path }
        format.xml  { render :xml => @idea, :status => :created, :location => @idea }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.xml
  def update
    @idea = Idea.find(params[:id])

    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        flash[:notice] = 'Idea was successfully updated.'
        format.html { redirect_to(@idea) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.xml
  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to(ideas_url) }
      format.xml  { head :ok }
    end
  end
end
