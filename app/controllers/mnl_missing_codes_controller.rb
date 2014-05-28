class MnlMissingCodesController < ApplicationController
before_filter :check_administrator_role,
:except => [:mobile]
before_filter :login_required, :except => [:mobile]


  # GET /mnl_missing_codes
  # GET /mnl_missing_codes.xml
  def index
    @mnl_missing_codes = MnlMissingCode.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mnl_missing_codes }
    end
  end

  # GET /mnl_missing_codes/1
  # GET /mnl_missing_codes/1.xml
  def show
    @mnl_missing_code = MnlMissingCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mnl_missing_code }
    end
  end

  # GET /mnl_missing_codes/new
  # GET /mnl_missing_codes/new.xml
  def new
    @mnl_missing_code = MnlMissingCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mnl_missing_code }
    end
  end

  # GET /mnl_missing_codes/1/edit
  def edit
    @mnl_missing_code = MnlMissingCode.find(params[:id])
  end

  # POST /mnl_missing_codes
  # POST /mnl_missing_codes.xml
  def create
    @mnl_missing_code = MnlMissingCode.new(params[:mnl_missing_code])

    respond_to do |format|
      if @mnl_missing_code.save
        flash[:notice] = 'MnlMissingCode was successfully created.'
        format.html { redirect_to(@mnl_missing_code) }
        format.xml  { render :xml => @mnl_missing_code, :status => :created, :location => @mnl_missing_code }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mnl_missing_code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mnl_missing_codes/1
  # PUT /mnl_missing_codes/1.xml
  def update
    @mnl_missing_code = MnlMissingCode.find(params[:id])

    respond_to do |format|
      if @mnl_missing_code.update_attributes(params[:mnl_missing_code])
        flash[:notice] = 'MnlMissingCode was successfully updated.'
        format.html { redirect_to(@mnl_missing_code) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mnl_missing_code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mnl_missing_codes/1
  # DELETE /mnl_missing_codes/1.xml
  def destroy
    @mnl_missing_code = MnlMissingCode.find(params[:id])
    @mnl_missing_code.destroy

    respond_to do |format|
      format.html { redirect_to(mnl_missing_codes_url) }
      format.xml  { head :ok }
    end
  end

  def mobile
    val = params[:info].tr("_"," ")
    code = val[0,val.index('~')]
    detail = val[val.index('~')+1,val.length]
    info = "#{code} - #{detail}"
    @mnl_missing_code = MnlMissingCode.new(:code=>code,:detail=>detail)
    if @mnl_missing_code.save
      render :text=>"Code Submitted Sucessfully. Thank you for submission, we will review and update in our next release. Meanwhile you can search it in our online database using search online section. Have you checked our new features? Now you can create your own collection of apps checkout killermobi.com/downloads - KillerMobi"
      # UserMailer.mnl_missing_code_notification(info).deliver
    else
    render :text=>"Error in submission"
    end
  end
end
