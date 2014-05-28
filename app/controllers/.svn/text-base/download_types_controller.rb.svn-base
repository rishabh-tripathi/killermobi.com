class DownloadTypesController < ApplicationController
  # GET /download_types
  # GET /download_types.xml
  def index
    @download_types = DownloadType.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @download_types }
    end
  end

  # GET /download_types/1
  # GET /download_types/1.xml
  def show
    @download_type = DownloadType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @download_type }
    end
  end

  # GET /download_types/new
  # GET /download_types/new.xml
  def new
    @download_type = DownloadType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @download_type }
    end
  end

  # GET /download_types/1/edit
  def edit
    @download_type = DownloadType.find(params[:id])
  end

  # POST /download_types
  # POST /download_types.xml
  def create
    @download_type = DownloadType.new(params[:download_type])

    respond_to do |format|
      if @download_type.save
        flash[:notice] = 'DownloadType was successfully created.'
        format.html { redirect_to(@download_type) }
        format.xml  { render :xml => @download_type, :status => :created, :location => @download_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @download_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /download_types/1
  # PUT /download_types/1.xml
  def update
    @download_type = DownloadType.find(params[:id])

    respond_to do |format|
      if @download_type.update_attributes(params[:download_type])
        flash[:notice] = 'DownloadType was successfully updated.'
        format.html { redirect_to(@download_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @download_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /download_types/1
  # DELETE /download_types/1.xml
  def destroy
    @download_type = DownloadType.find(params[:id])
    @download_type.destroy

    respond_to do |format|
      format.html { redirect_to(download_types_url) }
      format.xml  { head :ok }
    end
  end
end
