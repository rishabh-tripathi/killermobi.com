#require 'admob'
class Mobile::BaseController < BaseController
layout 'mobile'
## add this snippet ##
#  before_filter :admob_set_cookie
#
#  def admob_set_cookie
#    AdMob::set_cookie(request, cookies)
#  end
## end snippet ##

def home
@recommanded_download = Download.find(:all, :limit => 8, :order=>"download_count desc")
end

# Category Pages ############################################################
def category
@category = DownloadCategory.find(:first, :conditions => ["category = ?", params[:category]])
@keywords = @category.seo_keyword
@page_desc = @category.seo_description
@title = @category.page_title
@download = Download.find(:all, :conditions => ["category_id = ?", @category.id])
end
#############################################################################

# Downloads type ############################################################
def javame
@download = Download.find(:all, :conditions => ["type_id = 1"])
@title = "Free J2ME Mobile Applications - Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Softwares"
@keywords = "j2me mobile application,j2me application download,j2me developer,j2me development,free mobile downloads,best mobile software free download,download mobile application,download mobile games,download software for mobile,free mobile application,free mobile application downloads,free mobile software download,games for mobile phones,j2me mobile application,j2me application download,killer mobile application,killer mobile software,mobile application downloads,mobile application free,mobile application games,mobile application j2me,mobile application software download,mobile application software free download,mobile game download,mobile jar download,mobile solutions,s60 application download,samsung mobile application download,symbian mobile application,windows mobile applications,windows mobile application free download"
@page_desc = "Download free j2me applications, best j2me applications,free j2me softwares, free java application for nokia,samsung,sony erricson,lg,motorola and all java supported handsets."
end

def symbian
@download = Download.find(:all, :conditions => ["type_id = 2"])
@title = "Free Symbian Mobile Applications - Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Softwares"
@keywords = "s60 application download,sis application download,symbian mobile application,free mobile downloads,best mobile software free download,download mobile application,download mobile games,download software for mobile,free mobile application,free mobile application downloads,free mobile software download,games for mobile phones,j2me mobile application,j2me application download,killer mobile application,killer mobile software,mobile application downloads,mobile application free,mobile application games,mobile application j2me,mobile application software download,mobile application software free download,mobile game download,mobile jar download,mobile solutions,s60 application download,samsung mobile application download,symbian mobile application,windows mobile applications,windows mobile application free download"
@page_desc = "Download free symbian applications, best symbian applications,free symbian softwares, free symbian application for nokia."
end

def blackberry
@download = Download.find(:all, :conditions => ["type_id = 3"])
@title = "Free Blackberry Mobile Applications - Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Softwares"
@keywords = "blackberry mobile application,blackberry application development,free mobile downloads,best mobile software free download,download mobile application,download mobile games,download software for mobile,free mobile application,free mobile application downloads,free mobile software download,games for mobile phones,j2me mobile application,j2me application download,killer mobile application,killer mobile software,mobile application downloads,mobile application free,mobile application games,mobile application j2me,mobile application software download,mobile application software free download,mobile game download,mobile jar download,mobile solutions,s60 application download,samsung mobile application download,symbian mobile application,windows mobile applications,windows mobile application free download"
@page_desc = "Download free blackberry applications,free blackberry softwares,best blackberry applications, free blackberry application for all supported handsets."
end

def android
@download = Download.find(:all, :conditions => ["type_id = 4"])
@title = "Free Android Mobile Applications - Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Softwares"
@keywords = "free mobile downloads,best mobile software free download,download mobile application,download mobile games,download software for mobile,free mobile application,free mobile application downloads,free mobile software download,games for mobile phones,j2me mobile application,j2me application download,killer mobile application,killer mobile software,mobile application downloads,mobile application free,mobile application games,mobile application j2me,mobile application software download,mobile application software free download,mobile game download,mobile jar download,mobile solutions,s60 application download,samsung mobile application download,symbian mobile application,windows mobile applications,windows mobile application free download"
end

def windows
@download = Download.find(:all, :conditions => ["type_id = 5"])
@title = "Free Windows Mobile Applications - Free Mobile Downloads - Free Mobile Application - Free Mobile Software - Best Mobile Applications - Killer Mobile Softwares"
@keywords = "windows mobile application,windows mobile applications,windows mobile application free download,free mobile downloads,best mobile software free download,download mobile application,download mobile games,download software for mobile,free mobile application,free mobile application downloads,free mobile software download,games for mobile phones,j2me mobile application,j2me application download,killer mobile application,killer mobile software,mobile application downloads,mobile application free,mobile application games,mobile application j2me,mobile application software download,mobile application software free download,mobile game download,mobile jar download,mobile solutions,s60 application download,samsung mobile application download,symbian mobile application,windows mobile applications,windows mobile application free download"
@page_desc = "Download free windows mobile applications,free windows mobile softwares,best windows mobile applications, free windows mobile application for all supported handsets."
end

#############################################################################

end
