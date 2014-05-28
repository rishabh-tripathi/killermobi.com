class BetaCommentsController < ApplicationController
before_filter :check_administrator_role,
:except => [:new, :create]
before_filter :login_required, :except => [:new, :create]

  # GET /beta_comments
  # GET /beta_comments.xml
  def index
    @beta_comments = BetaComment.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @beta_comments }
    end
  end

  # GET /beta_comments/1
  # GET /beta_comments/1.xml
  def show
    @beta_comment = BetaComment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @beta_comment }
    end
  end

  # GET /beta_comments/new
  # GET /beta_comments/new.xml
  def new
    @beta_comment = BetaComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @beta_comment }
    end
  end

  # GET /beta_comments/1/edit
  def edit
    @beta_comment = BetaComment.find(params[:id])
  end

  # POST /beta_comments
  # POST /beta_comments.xml
  def create
    @beta_comment = BetaComment.new(params[:beta_comment])

    respond_to do |format|
      if @beta_comment.save
      @beta_comment.update_attribute(:app,params[:app])
        flash[:notice] = 'Your comment was successfully submitted.'
        format.html { redirect_to(beta_url) }
        format.xml  { render :xml => @beta_comment, :status => :created, :location => @beta_comment }
      else
        format.html { redirect_to(beta_url) }
        format.xml  { render :xml => @beta_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /beta_comments/1
  # PUT /beta_comments/1.xml
  def update
    @beta_comment = BetaComment.find(params[:id])

    respond_to do |format|
      if @beta_comment.update_attributes(params[:beta_comment])
        flash[:notice] = 'BetaComment was successfully updated.'
        format.html { redirect_to(@beta_comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @beta_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /beta_comments/1
  # DELETE /beta_comments/1.xml
  def destroy
    @beta_comment = BetaComment.find(params[:id])
    @beta_comment.destroy

    respond_to do |format|
      format.html { redirect_to(beta_comments_url) }
      format.xml  { head :ok }
    end
  end
end
