class BaseController < ApplicationController
before_filter :set_title

def set_title
@title = "Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Software"
end

def home
  @home = true
  @title = "Free Mobile Software and Solution - KillerMobi"
  @keywords = "free mobile software, free mobile applications, mobile phone software, mobile solutions, bluetooth software"
  @page_desc = "KillerMobi - One Stop Mobile Solutions, A web portal for free mobile software and applications. Here you can get free mobile solutions for your phone. Download free mobile applications and keep your phone updated with the killer mobile apps."
  @new_downloads = Download.find(:all, :order => 'created_at DESC', :limit =>15)
  @recommanded_download = Download.find(:all, :limit => 7, :order=>"download_count desc")

  # @forum = Forum.find(:all, :order => 'created_at DESC')
  # @topic = Topic.find(:all, :limit =>3, :order => 'created_at DESC')
  # @post = Post.find(:all, :limit =>4, :order => 'created_at DESC')
  # @articles = Article.find(:all, :conditions => "published=true", :limit =>3, :order => 'created_at DESC')
  # @article_category = Category.find(:all)

#  @top_buckets = Bucket.find(:all, :conditions => "download_count > 0 and access = #{Bucket::ACCESS_PUBLIC} and status != #{Bucket::STATUS_DELETED}", :order => "download_count desc", :limit => 3)
  @top_buckets = Bucket.find(:all, :conditions => "download_count > 0 and status != #{Bucket::STATUS_DELETED}", :order => "download_count desc", :limit => 2)
  @top_bucket_images = {}
  for b in @top_buckets
    @top_bucket_images[b.id] = b.get_bucket_images_array
  end

end

def about

end

def g_search
end

def beta
 #   @comment = BetaComment.find(:all, :conditions => ["download_id = ?", @download.id])
    @beta_comment = BetaComment.new
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @download }
    end
end

def private_policy
end

def contact
end

def send_contact
  if(check_real_spam_id(params[:_user_auth_key]))
    name = params[:mail][:user]
    email = params[:mail][:email]
    subject = params[:mail][:subject]
    message = params[:mail][:message]
    UserMailer.contact_us_mail(name, email, subject, message).deliver
    flash[:notice] = 'Your message sent successfully. Thank You for your response.'
    redirect_to root_path
  else
    redirect_to contact_url
  end
end

def link
end

def advertiser
end

def offer
end

# Downloads type ############################################################
def javame
@downloads = Download.paginate(:page => params[:page], :conditions => ["type_id = 1"], :order => 'created_at DESC')
@title = "Free J2ME Mobile Applications - Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Softwares"
@keywords = "j2me mobile application,j2me application download,j2me developer,j2me development,free mobile downloads,best mobile software free download,download mobile application,download mobile games,download software for mobile,free mobile application,free mobile application downloads,free mobile software download,games for mobile phones,j2me mobile application,j2me application download,killer mobile application,killer mobile software,mobile application downloads,mobile application free,mobile application games,mobile application j2me,mobile application software download,mobile application software free download,mobile game download,mobile jar download,mobile solutions,s60 application download,samsung mobile application download,symbian mobile application,windows mobile applications,windows mobile application free download"
@page_desc = "Download free j2me applications, best j2me applications,free j2me softwares, free java application for nokia,samsung,sony erricson,lg,motorola and all java supported handsets."
# @tags = Download.tag_counts
end

def symbian
@downloads = Download.paginate(:page => params[:page], :conditions => ["type_id = 2"], :order => 'created_at DESC')
@title = "Free Symbian Mobile Applications - Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Softwares"
@keywords = "s60 application download,sis application download,symbian mobile application,free mobile downloads,best mobile software free download,download mobile application,download mobile games,download software for mobile,free mobile application,free mobile application downloads,free mobile software download,games for mobile phones,j2me mobile application,j2me application download,killer mobile application,killer mobile software,mobile application downloads,mobile application free,mobile application games,mobile application j2me,mobile application software download,mobile application software free download,mobile game download,mobile jar download,mobile solutions,s60 application download,samsung mobile application download,symbian mobile application,windows mobile applications,windows mobile application free download"
@page_desc = "Download free symbian applications, best symbian applications,free symbian softwares, free symbian application for nokia."
# @tags = Download.tag_counts
end

def blackberry
@downloads = Download.paginate(:page => params[:page], :conditions => ["type_id = 3"], :order => 'created_at DESC')
@title = "Free Blackberry Mobile Applications - Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Softwares"
@keywords = "blackberry mobile application,blackberry application development,free mobile downloads,best mobile software free download,download mobile application,download mobile games,download software for mobile,free mobile application,free mobile application downloads,free mobile software download,games for mobile phones,j2me mobile application,j2me application download,killer mobile application,killer mobile software,mobile application downloads,mobile application free,mobile application games,mobile application j2me,mobile application software download,mobile application software free download,mobile game download,mobile jar download,mobile solutions,s60 application download,samsung mobile application download,symbian mobile application,windows mobile applications,windows mobile application free download"
@page_desc = "Download free blackberry applications,free blackberry softwares,best blackberry applications, free blackberry application for all supported handsets."
# @tags = Download.tag_counts
end

def android
@downloads = Download.paginate(:page => params[:page], :conditions => ["type_id = 4"], :order => 'created_at DESC')
@title = "Free Android Mobile Applications - Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Softwares"
@keywords = "free mobile downloads,best mobile software free download,download mobile application,download mobile games,download software for mobile,free mobile application,free mobile application downloads,free mobile software download,games for mobile phones,j2me mobile application,j2me application download,killer mobile application,killer mobile software,mobile application downloads,mobile application free,mobile application games,mobile application j2me,mobile application software download,mobile application software free download,mobile game download,mobile jar download,mobile solutions,s60 application download,samsung mobile application download,symbian mobile application,windows mobile applications,windows mobile application free download"
# @tags = Download.tag_counts
end

def windows
@downloads = Download.paginate(:page => params[:page], :conditions => ["type_id = 5"], :order => 'created_at DESC')
@title = "Free Windows Mobile Applications - Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Softwares"
@keywords = "windows mobile application,windows mobile applications,windows mobile application free download,free mobile downloads,best mobile software free download,download mobile application,download mobile games,download software for mobile,free mobile application,free mobile application downloads,free mobile software download,games for mobile phones,j2me mobile application,j2me application download,killer mobile application,killer mobile software,mobile application downloads,mobile application free,mobile application games,mobile application j2me,mobile application software download,mobile application software free download,mobile game download,mobile jar download,mobile solutions,s60 application download,samsung mobile application download,symbian mobile application,windows mobile applications,windows mobile application free download"
@page_desc = "Download free windows mobile applications,free windows mobile softwares,best windows mobile applications, free windows mobile application for all supported handsets."
# @tags = Download.tag_counts
end

#############################################################################

# method to send share email from mobile #####################################
def share_from_mobile
  email = params[:email]
  email = email.tr("~","@")
  email = email.tr("-",".")
  msg = params[:msg].tr("_"," ")
  app = params[:app].tr("_"," ")
  UserMailer.share_this_mobile_mail(email, app, msg).deliver
  render :text => "Message sent successfully"
end

def feedback_from_mobile
email = params[:email]
email = email.tr("~","@")
email = email.tr("-",".")
msg = params[:msg].tr("_"," ")
app = params[:app].tr("_"," ")
UserMailer.feedback_mobile_mail(email, app, msg).deliver
render :text => "Thank You for your feedback. We will be get in touch with you as soon as possible."
end

# method for mobile licence activation #################################
def activating_licence_mobile
code = params[:code]
imei = params[:imei]
number = params[:number]
@licence = Licence.find_by_code(code)
if(!@licence.nil?)
        if(@licence.status == 0)
                @licence.update_attribute(:status,"1")
                @licence.update_attribute(:imei,imei)
                @licence.update_attribute(:mobile_no,number)
                render :text => "111" # ok
        else
                render :text => "222" # Used Licence
        end
else
render :text => "000"   # Wrong Licence Key
end

end
########################################################################

end
