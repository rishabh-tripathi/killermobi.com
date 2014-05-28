class DownloadsController < ApplicationController
before_filter :set_title
before_filter :check_administrator_role,
:only => [:new, :edit, :create, :update, :destroy, :uploadFile]
before_filter :login_required, :except => [:all_downloads, :index, :show, :tag_page_show, :show_bucket, :list_bucket]


def set_title
  @title = "Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Software"
end

def index
  base_cond_str = "status = #{Download::APP_FOR_PUBLIC}"
  if(!params[:category].nil? && !params[:category].empty?)
    @category = nil
    Download::CAT_NAMES.each do|key,value|
      if(value.downcase == params[:category].downcase.gsub('_',' '))
        @category = key
      end
    end
    # @keywords = @category.seo_keyword
    # @page_desc = @category.seo_description
    # @title = @category.page_title
    @downloads = Download.paginate(:page => params[:page], :conditions => ["category_id = ? and #{base_cond_str}", @category], :order => 'created_at DESC')
  elsif(!params[:type].nil? && !params[:type].empty?)
    params[:type] = "JavaME" if(params[:type].downcase == "j2me")
    Download::PLATFORM_NAMES.each do|key,value|
      if(value.downcase == params[:type].downcase.gsub('_',' '))
        @platform = key
      end
    end
    cond_str = "type_id = #{@platform} and #{base_cond_str}"
    @category = nil
    if(!params[:p_category].nil? && !params[:p_category].empty?)
      Download::CAT_NAMES.each do|key,value|
        if(value.downcase == params[:p_category].downcase.gsub('_',' '))
          @category = key
        end
      end
      cond_str += " and category_id = #{@category} and #{base_cond_str}"
    end
    @downloads = Download.paginate(:page => params[:page], :conditions => cond_str, :order => 'created_at DESC')
  else
    @downloads = Download.paginate(:page => params[:page], :conditions => base_cond_str,:order => 'created_at DESC')
    @title = "Download Free Mobile Software - KillerMobi"
    @keywords = "free mobile software, free mobile applications, mobile phone software, mobile solutions, bluetooth software, bluetooth chat application, classroom chat, java mobile game, sanke game, snake war, snakewar game, snakewar mobile game"
    @page_desc = "Download free mobile software. Download Killer Mobile Applications, Free mobile applications for your phone. Download free bluetooth chat application. Download SnakeWar free mobile game"
  end
  if(Util.none(params[:page]))
    render(:partial => "show_more_apps_res")
  else
    @user_buckets = nil
    @user_buckets = Bucket.search_all_user_buckets(logged_in_user, 3) if(!logged_in_user.nil?)
  end
end

def show
  title = params[:title].tr("_"," ")
  @download = Download.find_by_title(title)
  if(!@download.nil?)
    # @tags = @download.tag_counts
    @keywords = @download.seo_keyword if(!@download.seo_keyword.nil?)
    @page_desc = @download.seo_description if(!@download.seo_description.nil?)
    title = "#{@download.title} "
    title += " - by #{@download.powered_by}" if(!@download.powered_by.nil? && !@download.powered_by.empty?)
    @title =   title+" - Free Mobile Software - KillerMobi"
    @category = @download.category_id
    @type = @download.type_id
    @reviews = Review.search_for_obj(Review::OBJ_TYPE_APP, @download.id)
    @best_review = nil
    if(!@reviews.nil? && !@reviews.empty?)
      for r in @reviews.sort{|a,b| b.rating <=> a.rating }
        if(r.review.size > 5)
          @best_review = r
          break
        end
      end
    end

    @avg_rating = 0
    if(!@reviews.nil? && !@reviews.empty?)
      total = 0
      @reviews.map{|a| total += a.rating }
      @avg_rating = total/@reviews.size if(total > 0)
    end

    @new_apps = Download.find(:all, :order => "created_at desc", :limit => 6)
    @top_cat_apps = Download.find(:all, :conditions => "category_id = #{@download.category_id}", :order => "download_count desc", :limit => 5)
    @similar_apps = Download.find(:all, :conditions => "type_id = #{@download.type_id} and category_id = #{@download.category_id} and id != #{@download.id}", :order => "download_count desc", :limit => 6)

    @bucket = nil
    @not_in_bucket = true
    if(!logged_in_user.nil? && logged_in_user.current_bucket > 0)
      (@bucket, @bucket_item) = Bucket.search_bucket(logged_in_user.current_bucket)
      @not_in_bucket = false if(!@bucket_item.nil? && !@bucket_item.empty? && (@bucket_item.map{|x| x.obj_id}.include? @download.id))
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @download }
    end
  else
    render(:text => "Invalid url")
  end
end

def new
  @download = Download.new
  @category = DownloadCategory.find(:all)
  @type = DownloadType.find(:all)
  respond_to do |format|
    format.html # new.html.erb
    format.xml  { render :xml => @download }
  end
end

def edit
  title = params[:title].tr("_"," ")
  @download = Download.find_by_title(params[:title])
  @category = DownloadCategory.find(:all)
  @type = DownloadType.find(:all)
  logger.info("\n\n\n#{@download.title}\n\n\n")
  respond_to do |format|
    format.html # new.html.erb
  end
end

def create
  @download = Download.new(params[:download])
  respond_to do |format|
    if @download.save
      flash[:notice] = 'Download was successfully created.'
      format.html { redirect_to(download_file_url(@download.id)) }
      format.xml  { render :xml => @download, :status => :created, :location => @download }
    else
      format.html { render :action => "new" }
      format.xml  { render :xml => @download.errors, :status => :unprocessable_entity }
    end
  end
end

def files
  @id = params[:id]
end

def update
  @download = Download.find(params[:id])
  respond_to do |format|
    if @download.update_attributes(params[:download])
      flash[:notice] = 'Download was successfully updated.'
      format.html { redirect_to download_url }
      format.xml  { head :ok }
    else
      format.html { render :action => "edit" }
      format.xml  { render :xml => @download.errors, :status => :unprocessable_entity }
    end
  end
end

def destroy
  @download = Download.find(params[:id])
  @download.destroy
  respond_to do |format|
    format.html { redirect_to(downloads_url) }
    format.xml  { head :ok }
  end
end

def uploadFile
  @id = params[:download_id]
  if(params[:uploadurl].nil?)
    post = Download.save(params[:upload],"JARs",@id)
    post = Download.save(params[:upload1],"JADs",@id)
  else
    @download = Download.find(@id)
    url = params[:uploadurl].to_s.gsub(/datafile/,'')
    @download.update_attribute(:file1url,url)
  end
  post = Download.save(params[:ss1],"ScreenShot1",@id)
  post = Download.save(params[:ss2],"ScreenShot2",@id)
  post = Download.save(params[:ss3],"ScreenShot3",@id)
  respond_to do |format|
    flash[:notice] = 'Files are successfully uploaded.'
    format.html { redirect_to(downloads_url) }
  end
end

def addComment
  @download_comment = DownloadComment.new(params[:download_comment])
  @download_comment.download_id = params[:download_id]
  @download_comment.user_id = logged_in_user
  @download = Download.find(params[:download_id])
  respond_to do |format|
    if @download_comment.save
      flash[:notice] = 'Comment added successfully.'
      format.html { redirect_to(download_show_url(@download.title.tr(" ","_"))) }
    else
      flash[:notice] = 'Error in adding comment. Please try later.'
      format.html { redirect_to(download_show_url(@download.title.tr(" ","_"))) }
    end
  end
end

def give_file
  title = params[:title].tr("_"," ")
  @download = Download.find_by_title(title)
  new_count = @download.download_count
  if(!new_count.nil?)
    new_count = new_count+1
  else
    new_count = 1
  end

  day_count = @download.day_count
  if(!day_count.nil?)
    day_count = day_count+1
  else
    day_count = 1
  end

  week_count = @download.week_count
  if(!week_count.nil?)
    week_count = week_count+1
  else
    week_count = 1
  end

  month_count = @download.month_count
  if(!month_count.nil?)
    month_count = month_count+1
  else
    month_count = 1
  end

  @download.update_attribute(:download_count,new_count)
  @download.update_attribute(:day_count,day_count)
  @download.update_attribute(:week_count,week_count)
  @download.update_attribute(:month_count,month_count)

  if is_logged_in?
    user = UserDetail.find_by_user_id(logged_in_user.id)
    if(user.nil?)
      user = UserDetail.new
      user.user_id = logged_in_user.id
      user.save
    end
    user_id = @download.users_ids
    if(!user_id.nil? && !user_id.empty?)
      user_id += logged_in_user.id.to_s+":"
    else
      user_id = logged_in_user.id.to_s+":"
    end
    @download.update_attribute(:users_ids, user_id)
    user_apps = user.dwld_apps_ids.split(":").uniq
    user_apps << @download.id.to_s
    user_apps.uniq!
    user.update_attribute(:dwld_apps_ids, user_apps.join(":"))
    UserMailer.after_download_notification(logged_in_user, @download).deliver
  end
  if(!(@download.file1url.include? "http://"))
    send_file "#{RAILS_ROOT}/public/#{@download.file1url}"
  else
    redirect_to @download.file1url
  end
end

def give_jad
  title = params[:title].tr("_"," ")
  @download = Download.find_by_title(title)
  send_file "#{RAILS_ROOT}/public/#{@download.file2url}"
end


def external_channel
  title = params[:title].tr("_"," ")
  @download = Download.find_by_title(title)
  @external = ExternalChannel.find_by_channel(params[:channel])
  new_count = @download.download_count
  if(!new_count.nil?)
    new_count = new_count+1
  else
    new_count = 1
  end

  new_count1 = @external.download_count
  if(!new_count1.nil?)
    new_count1 = new_count1+1
  else
    new_count1 = 1
  end

  new_count2 = @download.download_ext1
  if(!new_count2.nil?)
    new_count2 = new_count2+1
  else
    new_count2 = 1
  end

  @download.update_attribute(:download_count,new_count)
  @download.update_attribute(:download_ext1,new_count2)
  @external.update_attribute(:download_count,new_count1)
  if is_logged_in?
    UserMailer.after_download_notification(logged_in_user, @download).deliver
  end
  send_file "#{RAILS_ROOT}/public/#{@download.file1url}"
end

def external_channel_jad
  title = params[:title].tr("_"," ")
  @download = Download.find_by_title(title)
  send_file "#{RAILS_ROOT}/public/#{@download.file2url}"
end

# Method to edit tags #######################################################################
def remote_tag_edit
  title = params[:title].tr("_"," ")
  @downloads = Download.find_by_title(title)
  render(:layout => false)
end

def remote_tag_update
  title = params[:title].tr("_"," ")
  @download = Download.find_by_title(title)
  if logged_in_user.has_role?('Administrator')
    @download.tag_list = params[:downloads][:tag_list]
  else
    @download.tag_list.add(params[:download_tag][:new_tag])
  end
  if @download.save
    @tags = @download.tag_counts
    render(:partial => "show_tags")
  else
    render :text => "Error updating tags"
  end
end

def tag_page_show
#  @category = params[:tag] ||= ""
#  @download = Download.find_tagged_with(@category)
#  respond_to do |format|
#    format.html #default
#    format.xml { render :xml => @recipes}
#  end
  redirect_to download_url
end
############################################################################################



# action for bucket
def create_bucket
  bucket = Bucket.create_empty_bucket(params[:bucket_name], logged_in_user)
  if(!bucket.nil?)
    render(:partial => "dropables", :locals => {:bucket => bucket})
  else
    render(:text => "Error in creating bucket")
  end
end

def add_bucket_item
  bucket_item = BucketItem.add_item_to_bucket(Bucket.find(params[:bucket].to_i), params[:item_type].to_i, params[:item_id].gsub('drag_download_','').to_i)
  if(!bucket_item.nil?)
    render(:text => "")
  else
    render(:text => "Error in adding item")
  end
end

def remove_bucket_item
  bucket_item = BucketItem.find(:first, :conditions => ["bucket_id = ? and obj_id = ?", params[:bucket].to_i, params[:item_id].to_i])
  if(!bucket_item.nil?)
    bucket_item.destroy
    render(:text => "")
  else
    render(:text => "Error in removing item")
  end
end

def prepare_bucket
  require 'zip/zip'
  require 'zip/zipfilesystem'
  (bucket, bucket_item) = Bucket.search_bucket(params[:bucket].to_i)
  file_name = random_alphanumeric(30)
  file_path = "./public/killer_downloads/buckets/#{file_name}.zip"
  if(!bucket.nil? && !bucket_item.nil? && !bucket_item.empty?)
    t = File.open(file_path, "w+")
    Zip::ZipOutputStream.open(file_path) do |z|
      bucket_access = Bucket::ACCESS_PUBLIC
      for item in bucket_item
        bucket_access = Bucket::ACCESS_PRIVATE if(item.access == BucketItem::ACCESS_PRIVATE)
        path = item.item_path
        if(!path.empty?)
          path.each do |p|
            begin
              title = p.split("/").last
              z.put_next_entry(title)
              if(p.include? "./")
                z.print IO.read("#{p}")
              else
                z.print IO.read("./public/#{p}")
              end
            rescue Exception => e
              logger.info("\n#{e.to_s}\n")
            end
          end
        end
      end
      bucket.update_attribute(:access, bucket_access)
    end
    t.close()
    bucket.zip_path = "/killer_downloads/buckets/#{file_name}.zip"
    bucket.zip_name = "#{bucket.name.gsub(' ','-')}-bucket-killermobi.zip"
    bucket.download_id = random_alphanumeric(30)
    bucket.save
    logged_in_user.update_attribute(:current_bucket, 0)
  end
  render(:partial => "bucket_ready", :locals => {:bucket => bucket, :bucket_item => bucket_item})
end

def reset_bucket
  (bucket, bucket_item) = Bucket.search_bucket(params[:bucket].to_i)
  remove_bucket_item = []
  bucket_item.map{|a| remove_bucket_item << "#{a.obj_id}-#{a.obj_type}"}
  bucket_item.map{|a| a.destroy }
  if(!bucket.nil?)
    render(:partial => "dropables", :locals => {:bucket => bucket, :removed_bucket_item => remove_bucket_item})
  else
    render(:text => "Error in creating bucket")
  end
end

def add_to_bucket
  if(!logged_in_user.nil?)
    if(logged_in_user.current_bucket > 0)
      (bucket, bucket_item) = Bucket.search_bucket(logged_in_user.current_bucket)
      if(!(bucket_item.map{|x| x.obj_id }.include? params[:item_id].to_i))
        b_item = BucketItem.add_item_to_bucket(bucket, params[:item_type].to_i, params[:item_id])
        bucket_item << b_item
      end
      render(:partial => "dropables", :locals => {:bucket => bucket, :bucket_item => bucket_item})
    else
      render(:partial => "make_bucket")
    end
  else
    render(:partial => "device_login")
  end
end

def new_bucket
  (bucket, bucket_item) = Bucket.search_bucket(logged_in_user.current_bucket)
  remove_bucket_item = []
  bucket_item.map{|a| remove_bucket_item << a.obj_id}
  logged_in_user.update_attribute(:current_bucket, 0)
  render(:partial => "make_bucket", :locals => {:removed_bucket_item => remove_bucket_item})
end

def set_bucket
  (bucket, bucket_item) = Bucket.search_bucket(params[:bucket].to_i)
  if(!bucket.nil?)
    if(logged_in_user.current_bucket > 0)
      (old_bucket, old_bucket_item) = Bucket.search_bucket(logged_in_user.current_bucket)
      remove_bucket_item = []
      if(bucket.id != old_bucket.id)
        old_bucket_item.map{|a| remove_bucket_item << "#{a.obj_id}-#{a.obj_type}"}
      end
    end
    logged_in_user.update_attribute(:current_bucket, bucket.id)
    render(:partial => "dropables", :locals => {:bucket => bucket, :bucket_item => bucket_item, :removed_bucket_item => remove_bucket_item})
  else
    render(:text => "Error in setting bucket")
  end
end

def download_bucket
  bucket = Bucket.search_by_download_id(params[:id]) if(!params[:id].nil? && !params[:id].empty?)
  if(!bucket.nil?)
    bucket.update_attribute(:download_count, bucket.download_count+=1)
    send_file "./public#{bucket.zip_path}", :type => 'application/zip', :disposition => 'attachment', :filename => bucket.zip_name
  else
    render(:text => "No bucket available for download")
  end
end

def show_bucket
  name = params[:name].gsub("-"," ")
  (@bucket, @bucket_item) = Bucket.search_bucket_by_name(name)
  if(@bucket.nil?)
    (@bucket, @bucket_item) = Bucket.search_bucket_by_name(params[:name])
  end

  if((@bucket.access != Bucket::ACCESS_PRIVATE) || (!logged_in_user.nil? && (logged_in_user.id == @bucket.user_id)))
    apps_ids = []
    files_ids = []
    for item in @bucket_item
      if(item.obj_type == BucketItem::OBJ_TYPE_APP)
        apps_ids << item.obj_id
      else
        files_ids << item.obj_id
      end
    end

    @bucket_apps = []
    @bucket_files = []

    if(!apps_ids.empty?)
      @bucket_apps = Download.find(:all, :conditions => "id in (#{apps_ids.join(',')})")
    end

    if(!files_ids.empty?)
      @bucket_files = UploadedFile.find(:all, :conditions => "id in (#{files_ids.join(',')})")
    end

    @user_buckets = nil
    @user_buckets = Bucket.search_all_user_buckets(User.find(@bucket.user_id), 6)
    @user_buckets.delete(@bucket)
    @reviews = Review.search_for_obj(Review::OBJ_TYPE_BUCKET, @bucket.id)
    @avg_rating = 0
    if(!@reviews.nil? && !@reviews.empty?)
      total = 0
      @reviews.map{|a| total += a.rating }
      @avg_rating = total/@reviews.size if(total > 0)
    end
  else
    render(:text => "Sorry! this bucket is not public.")
  end
end

def list_bucket
  # add access condition also
  order_str = "created_at desc"
  condition_str = ""
  @user = nil
  if(!params[:username].nil? && !params[:username].empty?)
    if(params[:username].to_s == "recommanded") # will change this later
      order_str = "download_count desc"
    else
      @user = User.find_by_username(params[:username].gsub('-',' '))
      @user = User.find_by_username(params[:username]) if(@user.nil?)
      condition_str += "user_id = #{@user.id} and"
    end
  end
  @buckets = Bucket.paginate(:page => params[:page], :conditions => "#{condition_str} status > #{Bucket::STATUS_DELETED}", :order => order_str)
  @bucket_images = {}
  for b in @buckets
    @bucket_images[b.id] = b.get_bucket_images_array
  end

  @top_buckets = Bucket.find(:all, :order => "created_at desc", :limit => 5)
  @top_bucket_images = {}
  for b in @top_buckets
    @top_bucket_images[b.id] = b.get_bucket_images_array
  end

end

def submit_review
  review = Review.new(params[:review])
  review.save
  reviews = Review.search_for_obj(review.obj_type, review.obj_id)
  render(:partial => "review_list", :locals => {:no_of_reviews => 10, :reviews => reviews, :new_review => true})
end

# User upload action ######################################################
def upload
  @image = UploadedFile.search_files(logged_in_user, UploadedFile::FILE_CAT_IMAGE)
  @music = UploadedFile.search_files(logged_in_user, UploadedFile::FILE_CAT_MUSIC)
  @video = UploadedFile.search_files(logged_in_user, UploadedFile::FILE_CAT_VIDEO)
  @other_file = UploadedFile.search_files(logged_in_user, UploadedFile::FILE_CAT_FILES)
  @user_buckets = nil
  @user_buckets = Bucket.search_all_user_buckets(logged_in_user, 3) if(!logged_in_user.nil?)
end

def upload_file
  UploadedFile.save_file(logged_in_user, request, nil)
  render(:text => "Done")
end

def refresh_section
    files = UploadedFile.search_files(logged_in_user, params[:id].to_i)
    title =UploadedFile::FILE_CAT_NAMES[params[:id].to_i]
    section_id = "sec_#{title.downcase.tr(' ','_')}"
    render(:partial => "uploaded_files_container", :locals => {:files => files, :section_id => section_id, :title => title})
end

def remove_uploaded_file
  if(params[:file_id].to_s.include? ",")
    file_ids = params[:file_id]
    file = UploadedFile.find(:first, :conditions => ["id = ?", file_ids.split(",").first])
    UploadedFile.update_all("deleted = #{UploadedFile::DELETED}", "id in (#{file_ids})")
    files = UploadedFile.search_files(file.user_id, file.file_cat)
    title =UploadedFile::FILE_CAT_NAMES[file.file_cat]
    section_id = "sec_#{title.downcase.tr(' ','_')}"
    render(:partial => "uploaded_files_container", :locals => {:files => files, :section_id => section_id, :title => title})
  else
    file = UploadedFile.find(params[:file_id].to_i)
    if(!file.nil?)
      file.update_attribute(:deleted, UploadedFile::DELETED)
      render(:partial => "file_deleted_view")
    else
      thumb = file.get_thumb_image
      section_id = "sec_#{UploadedFile::FILE_CAT_NAMES[file.file_cat].downcase.gsub(' ','_')}"
      render(:partial => "file_view", :locals=> {:thumb_image => thumb, :f => file, :section_id => section_id})
    end
  end
end

def change_file_access
  if(params[:file_id].to_s.include? ",")
    file_ids = params[:file_id]
    file = UploadedFile.find(:first, :conditions => ["id = ?", file_ids.split(",").first])
    if(params[:access_action].to_i == UploadedFile::ACCESS_PRIVATE)
      UploadedFile.update_all("access = #{UploadedFile::ACCESS_PRIVATE}", "id in (#{file_ids})")
    elsif(params[:access_action].to_i == UploadedFile::ACCESS_PUBLIC)
      UploadedFile.update_all("access = #{UploadedFile::ACCESS_PUBLIC}", "id in (#{file_ids})")
    end
    files = UploadedFile.search_files(file.user_id, file.file_cat)
    title =UploadedFile::FILE_CAT_NAMES[file.file_cat]
    section_id = "sec_#{title.downcase.tr(' ','_')}"
    render(:partial => "uploaded_files_container", :locals => {:files => files, :section_id => section_id, :title => title})
  else
    file = UploadedFile.find(params[:file_id].to_i)
    access = 0
    if(file.access == UploadedFile::ACCESS_PRIVATE)
      access = UploadedFile::ACCESS_PUBLIC
    else
      access = UploadedFile::ACCESS_PRIVATE
    end
    file.update_attribute(:access, access)
    thumb = file.get_thumb_image
    section_id = "sec_#{UploadedFile::FILE_CAT_NAMES[file.file_cat].downcase.gsub(' ','_')}"
    render(:partial => "file_view", :locals=> {:thumb_image => thumb, :f => file, :section_id => section_id})
  end
end

def change_default_storage
  logged_in_user.update_attribute(:default_storage, params[:default_storage].to_i)
  render(:partial => "user_default_storage_form")
end

def download_uploaded_file
  if(Util.none(params[:token]))
    file = UploadedFile.find_by_token(params[:token])
    if(!file.nil?)
      if((file.access == UploadedFile::ACCESS_PUBLIC) || (!logged_in_user.nil? && (logged_in_user.id == file.user_id)))
        file.update_attribute(:download_count, file.download_count += 1)
        send_file file.get_local_path
        return
      else
        redirect_to login_url
      end
    else
      render :nothing => true, :status => 200, :content_type => 'text/html'
    end
  end
end

def all_downloads
  @apps = Download.find(:all, :conditions => "status = #{Download::APP_FOR_PUBLIC}", :order => "created_at desc", :limit => 27)
  @image = UploadedFile.find(:all, :conditions => ["deleted = 0 and file_cat = ? and access = ?", UploadedFile::FILE_CAT_IMAGE, UploadedFile::ACCESS_PUBLIC], :order => "created_at desc")
  @music = UploadedFile.find(:all, :conditions => ["deleted = 0 and file_cat = ? and access = ?", UploadedFile::FILE_CAT_MUSIC, UploadedFile::ACCESS_PUBLIC], :order => "created_at desc")
  @video = UploadedFile.find(:all, :conditions => ["deleted = 0 and file_cat = ? and access = ?", UploadedFile::FILE_CAT_VIDEO, UploadedFile::ACCESS_PUBLIC], :order => "created_at desc")
  @user_buckets = nil
  @user_buckets = Bucket.search_all_user_buckets(logged_in_user, 3) if(!logged_in_user.nil?)
end

# Share app functionality
def share_app
  @apps = Download.find(:all, :conditions => ["user_id = ?", logged_in_user.id], :order => "created_at desc")
  @user_buckets = Bucket.search_all_user_buckets(logged_in_user, 3) if(!logged_in_user.nil?)
end

# Step 1
def upld_basic_app_info
  u = logged_in_user
  if(!u.nil?)
    @dwld = Download.new
    @dwld.title = params[:upload_title]
    @dwld.category_id = params[:upload_category].to_i
    @dwld.type = Download::APP_USER_UPLOADED
    @dwld.description = params[:upload_desc]
    @dwld.user_id = u.id
    @dwld.status = Download::APP_UPLOADED
    @dwld.save
    render(:partial => "upld_app_res1")
  end
end

# Step 2
def upld_app_file
  msg = ""
  u_app = nil
  u = logged_in_user
  if(Util.none(params[:app_id]) && (params[:app_id].to_i > 0))
    u_app = Download.find_by_id(params[:app_id])
    if(!u.nil? && u.id == u_app.user_id)
      u_app.update_attribute(:type_id, params[:type].to_i)
      ud = UserDetail.find_by_user_id(u.id)
      UserDetail.set_user_uploads(ud, params[:app_id].to_i)
      begin
        path = "./public/user_data/uploaded_apps/#{u.id}/#{u_app.id}"
        FileUtils.mkdir_p(path)
        (f_name, file_name, file_type_str) = UploadedFile.dd_get_file_info(request, params)
        new_file_name = file_name+"."+file_type_str
        file_loc = "#{RAILS_ROOT}/public/user_data/uploaded_apps/#{u.id}/#{u_app.id}/#{new_file_name}"
        # deleting params for drag and drop file save
        params.delete(:app_id)
        params.delete(:type)
        params.delete(:controller)
        params.delete(:action)
        UploadedFile.dd_save_to_disk(file_loc, params, request)
        path = "/user_data/uploaded_apps/#{u.id}/#{u_app.id}/#{new_file_name}"
        u_app = Download.add_files_dd(path, u_app)
        u_app.save
        msg = "Done"
      rescue Exception => e
        logger.info("\n\n\n\n\n#{e.to_s}\n\n\n\n\n")
        msg = "Error"
      end
    end
  end
  render(:text => msg)
end

# Step 3
def upld_app_screenshots
  msg = ""
  u_app = nil
  u = logged_in_user
  if(Util.none(params[:app_id]) && (params[:app_id].to_i > 0))
    u_app = Download.find_by_id(params[:app_id])
    if(!u.nil? && (u.id == u_app.user_id))
      ud = UserDetail.find_by_user_id(u.id)
      UserDetail.set_user_uploads(ud, params[:app_id].to_i)
      begin
        path = "./public/user_data/uploaded_apps/#{u.id}/#{u_app.id}/screenshots"
        FileUtils.mkdir_p(path)
        (f_name, file_name, file_type_str) = UploadedFile.dd_get_file_info(request, params)
        new_file_name = file_name+"."+file_type_str
        file_loc = "#{RAILS_ROOT}/public/user_data/uploaded_apps/#{u.id}/#{u_app.id}/screenshots/#{new_file_name}"
        # deleting params for drag and drop file save
        params.delete(:app_id)
        params.delete(:controller)
        params.delete(:action)
        UploadedFile.dd_save_to_disk(file_loc, params, request)
        path = "/user_data/uploaded_apps/#{u.id}/#{u_app.id}/screenshots/#{new_file_name}"
        u_app = Download.add_screenshot_dd(path, u_app)
        u_app.save
        msg = "Done"
      rescue Exception => e
        logger.info("\n\n\n\n\n#{e.to_s}\n\n\n\n\n")
        msg = "Error"
      end
    end
  end
  render(:text => msg)
end

def upld_app_social_details
  u = logged_in_user
  if(Util.none(params[:upld_app_id]) && (params[:upld_app_id].to_i > 0))
    u_app = Download.find_by_id(params[:upld_app_id])
    if(!u.nil? && (u.id == u_app.user_id))
      u_app.fb_url = params[:fb_url] if(Util.none(params[:fb_url]))
      u_app.twitter_url = params[:twitter_url] if(Util.none(params[:twitter_url]))
      u_app.youtube_url = params[:youtube_url] if(Util.none(params[:youtube_url]))
      u_app.save
      render(:partial => "upld_app_res4", :locals => {:u_app => u_app})
    end
  end
end

def all_music
end

end
