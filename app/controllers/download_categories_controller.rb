class DownloadCategoriesController < ApplicationController
before_filter :check_administrator_role
before_filter :login_required

  # GET /download_categories
  # GET /download_categories.xml
  def index
    @download_categories = DownloadCategory.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @download_categories }
    end
  end

  # GET /download_categories/1
  # GET /download_categories/1.xml
  def show
    @download_category = DownloadCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @download_category }
    end
  end

  # GET /download_categories/new
  # GET /download_categories/new.xml
  def new
    @download_category = DownloadCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @download_category }
    end
  end

  # GET /download_categories/1/edit
  def edit
    @download_category = DownloadCategory.find(params[:id])
  end

  # POST /download_categories
  # POST /download_categories.xml
  def create
    @download_category = DownloadCategory.new(params[:download_category])

    respond_to do |format|
      if @download_category.save
        flash[:notice] = 'DownloadCategory was successfully created.'
        format.html { redirect_to(@download_category) }
        format.xml  { render :xml => @download_category, :status => :created, :location => @download_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @download_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /download_categories/1
  # PUT /download_categories/1.xml
  def update
    @download_category = DownloadCategory.find(params[:id])

    respond_to do |format|
      if @download_category.update_attributes(params[:download_category])
        flash[:notice] = 'DownloadCategory was successfully updated.'
        format.html { redirect_to(@download_category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @download_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /download_categories/1
  # DELETE /download_categories/1.xml
  def destroy
    @download_category = DownloadCategory.find(params[:id])
    @download_category.destroy

    respond_to do |format|
      format.html { redirect_to(download_categories_url) }
      format.xml  { head :ok }
    end
  end
end
