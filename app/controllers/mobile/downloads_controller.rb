#require 'admob'
class Mobile::DownloadsController < DownloadsController
layout 'mobile'

before_filter :login_required, :except => [:index, :show, :options, :screenshots]
## add this snippet ##
#        before_filter :admob_set_cookie
#
#        def admob_set_cookie
#          AdMob::set_cookie(request, cookies)
#        end
#        ## end snippet ##

def options
end

def screenshots
 title = params[:title].tr("_"," ")
    @download = Download.find_by_title(title)
end

  def index
    @new_downloads = Download.find(:all, :order => 'created_at DESC')

    @title = "Download Free Mobile Software - KillerMobi"
    @keywords = "free mobile software, free mobile applications, mobile phone software, mobile solutions, bluetooth software, bluetooth chat application, classroom chat, java mobile game, sanke game, snake war, snakewar game, snakewar mobile game"
    @page_desc = "Download free mobile software. Download Killer Mobile Applications, Free mobile applications for your phone. Download free bluetooth chat application. Download SnakeWar free mobile game"

      respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @downloads }
    end
  end

  # GET /downloads/1
  # GET /downloads/1.xml
  def show
    title = params[:title].tr("_"," ")
    @download = Download.find_by_title(title)

    @keywords = @download.seo_keyword
    @page_desc = @download.seo_description
    @title = "#{@download.title}  - by #{@download.powered_by} - Free Mobile Software - KillerMobi"

    @category = DownloadCategory.find(@download.category_id)
    @type = DownloadType.find(@download.type_id)
    @comment = DownloadComment.find(:all, :conditions => ["download_id = ?", @download.id])
    @download_comment = DownloadComment.new
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @download }
    end
  end

end
