class MnlOnlinesController < ApplicationController
before_filter :check_administrator_role,
:except => [:mobile]
before_filter :login_required, :except => [:mobile]

  # GET /mnl_onlines
  # GET /mnl_onlines.xml
  def index
    @mnl_onlines = MnlOnline.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mnl_onlines }
    end
  end

  # GET /mnl_onlines/1
  # GET /mnl_onlines/1.xml
  def show
    @mnl_online = MnlOnline.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mnl_online }
    end
  end

  # GET /mnl_onlines/new
  # GET /mnl_onlines/new.xml
  def new
    @mnl_online = MnlOnline.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mnl_online }
    end
  end

  # GET /mnl_onlines/1/edit
  def edit
    @mnl_online = MnlOnline.find(params[:id])
  end

  # POST /mnl_onlines
  # POST /mnl_onlines.xml
  def create
    @mnl_online = MnlOnline.new(params[:mnl_online])

    respond_to do |format|
      if @mnl_online.save
        flash[:notice] = 'MnlOnline was successfully created.'
        format.html { redirect_to(@mnl_online) }
        format.xml  { render :xml => @mnl_online, :status => :created, :location => @mnl_online }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mnl_online.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mnl_onlines/1
  # PUT /mnl_onlines/1.xml
  def update
    @mnl_online = MnlOnline.find(params[:id])

    respond_to do |format|
      if @mnl_online.update_attributes(params[:mnl_online])
        flash[:notice] = 'MnlOnline was successfully updated.'
        format.html { redirect_to(@mnl_online) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mnl_online.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mnl_onlines/1
  # DELETE /mnl_onlines/1.xml
  def destroy
    @mnl_online = MnlOnline.find(params[:id])
    @mnl_online.destroy

    respond_to do |format|
      format.html { redirect_to(mnl_onlines_url) }
      format.xml  { head :ok }
    end
  end

    def mobile
    val = params[:code]
    @report=MnlOnline.find_by_code(val)
    if(!@report.nil?)
      render :text=> "#{@report.detail} - Have you checked our new features? Now you can create your own collection of apps, checkout killermobi.com/downloads"
    else
	render :text=>"Code Not Found !! Please try later. If you have any information about this code then kindly submit it to report missing code section. Have you checked our new features? Now you can create your own collection of apps, checkout killermobi.com/downloads  - KillerMobi.com"
    end
    end
end
