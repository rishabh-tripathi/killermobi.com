class TaskController < ApplicationController

  def cron_download_daily
    if(params[:pass].to_s == "killermobidailydownloadcountupdate")
      Download::update_daily_count
    end
  end

  def cron_download_weekly
    if(params[:pass].to_s == "killermobiweeklydownloadcountupdate")
      Download::update_weekly_count
    end
  end

  def cron_download_monthly
    if(params[:pass].to_s == "killermobimonthlydownloadcountupdate")
      Download::update_monthly_count
    end
  end

end

