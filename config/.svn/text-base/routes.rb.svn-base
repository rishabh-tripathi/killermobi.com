Killermobi::Application.routes.draw do

  resources :authentications

  # top level urls #####################################################################################
  root :to => 'base#home'

  #match '/' => 'base#home' , :as => :index
  match '/about' => 'base#about', :as => :about
  match '/search_result' => 'base#g_search', :as => :g_search
  match '/PrivatePolicy' => 'base#private_policy', :as => :policy
  match '/beta' => 'base#beta', :as => :beta
  match '/contact' => 'base#contact', :as => :contact
  match '/ThankYou' => 'base#send_contact', :as => :contact_mail
  match '/links' => 'base#link', :as => :link
  match '/offers' => 'base#offers', :as => :offers
  match '/advertiser' => 'base#advertiser', :as => :advertise
  ######################################################################################################

  # users authentication urls ##########################################################################
  match '/auth/:provider' => 'authentications#blank'
  match '/auth/failure' => 'authentications#third_party_auth'
  match '/auth/:provider/callback' => 'authentications#create'

  devise_for :users, :controllers => {:omniauth_callbacks => 'authentications', :registrations => "registrations", :sessions => "sessions"} do
    get "/login" => "sessions#new", :as => :login
    get "/logout" => "sessions#destroy", :as => :logout
    get "/signup" => "registrations#new", :as => :signup
  end

  #match '/logout' => 'account#logout', :as => :logout
  #match '/login' => 'account#login', :as => :login
  #match '/validating' => 'account#authenticate', :as => :authenticate
  #match '/signup' => 'users#new', :as => :signup
  #match '/forget_password' => 'account#forget_password', :as => :forget_password
  #match '/recovering' => 'account#recover', :as => :recover

  match '/check_availability/username/' => 'users#availability_username', :as => :username_avail
  match '/check_availability/email/' => 'users#availability_email', :as => :email_avail
  match '/user/migrate/fb_to_killermobi' => 'users#migrate_fb_km', :as => :fb_km_migrate
  ######################################################################################################

  #resources ####################===[ To be remove]======###############################################
  resources :mnl_onlines
  resources :mnl_missing_codes
  resources :beta_comments
  resources :devices
  resources :download_comments
  resources :download_types
  resources :download_categories
  resources :ideas
  # resources :downloads
  resources :roles
  #resources :users do
  #member do
  #  put :enable
  #end
  #    resources :roles
  #end
  resources :articles do
    collection do
  get :admin
  end
  end
  resources :comments
  resources :entries
  resources :roles
  resources :permissions
  #########################################################################################################

  # user profile urls ################################################################################################
  match 'app/user-login' => 'device#app_user_login', :as => :app_user_login #not working need to fix
  match 'app/user-logout' => 'device#app_user_logout', :as => :app_user_logout#not working need to fix
  match 'app/user-login-form/:app_id/:app_key' => 'device#login_form', :as => :app_user_login_form, :app_key => nil , :app_id => nil#not working need to fix

  match '/user/:username' => 'users#show', :as => :show_user
  match '/profile/:username' => 'users#profile', :as => :profile
  match '/user-update-section/:section' => 'users#update_section', :as => :user_update_section

  match 'add-friend' => 'friends#add_friend', :as => :add_friend
  match 'accept-friend' => 'friends#accept_friend', :as => :accept_friend
  match 'reject-friend' => 'friends#reject_friend', :as => :reject_friend
  match 'remove-friend' => 'friends#remove_friend', :as => :remove_friend

  match '/user-upload-profile-pic' => 'users#upload_profile_pic', :as => :user_upload_pic, :method => 'POST'
  match '/user-edit-social-profile' => 'users#edit_social_profile', :as => :user_edit_social_profile

  # match '/user-upload-app-step_one' => 'users#upload_app_step1', :as => :user_upload_app1
  # match '/user-upload-app-file' => 'users#upload_app_file', :as => :user_upload_app_file
  # match '/user-upload-app-image' => 'users#upload_app_image', :as => :user_upload_app_image
  # match '/user-share-app-step-one' => 'users#share_app_step1', :as => :user_share_app1
  # match '/user-share-app-step-two' => 'users#share_app_step2', :as => :user_share_app2

  match '/user-create-virtual-device' => 'users#create_virtual_device', :as => :user_create_virtual_device
  match '/user-create-real-device' => 'users#create_real_device', :as => :user_create_real_device

  #routes for device messages
  match 'app/upload-user-message' => 'device#upload_user_message', :as => :app_user_upload_msg
  match '/user-write-message' => 'users#send_user_message', :as => :send_user_message

  ####################################################################################################################

  # article urls #####################################################################################################
  match '/articles/partners/to_publish' => 'articles#article_to_review', :as => :article_rev
  match '/articles/partners/to_publish/create' => 'articles#create_article_to_review', :as => :article_rev_create
  match '/articles/category/:category_name' => 'articles#index', :as => :article_cat
  match '/article/:title' => 'articles#show', :as => :show_article
  match '/article/:title/edit_tags' => 'articles#remote_tag_edit', :as => :remote_tag_edit_article
  match '/article/:title/update_tags' => 'articles#remote_tag_update', :as => :remote_tag_update_article
  match '/article/tags/:tag' => 'articles#tag_page_show', :as => :article_tagged
  ####################################################################################################################

  # Download urls ###################################################################################################
  match '/downloads' => 'downloads#all_downloads', :as => :download
  match '/download' => redirect('/downloads')

  match '/apps' => 'downloads#index', :as => :apps
  match '/app' => redirect('/apps')

  match '/apps/:category' => 'downloads#index', :as => :category
  match '/platform/:type(/:p_category)' => 'downloads#index', :as => :platform

  match '/download/:title' => 'downloads#show', :as => :download_show

  match '/download/new' => 'downloads#new', :as => :download_new
  match '/download/edit/:title' => 'downloads#edit', :as => :download_edit
  match '/download/edit/:id/edited' => 'downloads#update', :as => :download_editing
  match '/download/delete/:id' => 'downloads#destroy', :as => :download_delete
  match '/download/file/:id' => 'downloads#files', :as => :download_file
  match '/download/new/file' => 'downloads#uploadFile', :as => :download_new_file
  match '/download/comment/new' => 'downloads#addComment', :as => :download_comment
  match '/serve/file/:title' => 'downloads#give_file', :as => :give_file
  match '/serve/jad/:title' => 'downloads#give_jad', :as => :give_jad
  match '/serve/external/:channel/:title' => 'downloads#external_channel', :as => :give_file_external
  match '/serve/jad/external/:channel/:title' => 'downloads#external_channel_jad', :as => :give_jad_external
  match '/download/:title/edit_tags' => 'downloads#remote_tag_edit', :as => :remote_tag_edit_download
  match '/download/:title/update_tags' => 'downloads#remote_tag_update', :as => :remote_tag_update_download
  match '/download/tags/:tag' => 'downloads#tag_page_show', :as => :download_tagged
  ###############################################################################################################

  # bucket urls #################################################################################################
  match '/create-bucket' => 'downloads#create_bucket', :as => :create_bucket
  match '/add-bucket-item' => 'downloads#add_bucket_item', :as => :add_bucket_item
  match '/remove-bucket-item' => 'downloads#remove_bucket_item', :as => :remove_bucket_item
  match '/prepare-bucket' => 'downloads#prepare_bucket', :as => :prepare_bucket
  match '/download-bucket/:id' => 'downloads#download_bucket', :as => :download_bucket
  match '/reset-bucket' => 'downloads#reset_bucket', :as => :reset_bucket
  match '/set-bucket' => 'downloads#set_bucket', :as => :set_bucket
  match '/new-bucket' => 'downloads#new_bucket', :as => :new_bucket
  match '/add-to-bucket' => 'downloads#add_to_bucket', :as => :add_to_bucket

  match '/buckets(/:username)' => 'downloads#list_bucket', :as => :list_bucket
  match '/bucket/:name' => 'downloads#show_bucket', :as => :show_bucket
  ###############################################################################################################

  match '/upload-file/change-default-storage', :controller => 'downloads', :action => 'change_default_storage', :as => "change_default_storage"
  match '/upload-file', :controller => 'downloads', :action => 'upload_file', :as => "upload_file"
  match '/upload-file/refresh(/:id)', :controller => 'downloads', :action => 'refresh_section', :as => "refresh_section"
  match '/upload-file/change-access(/:type)', :controller => 'downloads', :action => 'change_file_access', :as => "change_access"
  match '/upload-file/remove-file(/:type)', :controller => 'downloads', :action => 'remove_uploaded_file', :as => "remove_uploaded_file"

  match '/upload-file/download/:token', :controller => 'downloads', :action => 'download_uploaded_file', :as => "download_uploaded_file"

  # dropbox url #################################################################################################
  match 'dropbox/authorize', :controller => 'dropbox', :action => 'authorize', :as => :dropbox_authorize
  match 'dropbox/upload', :controller => 'dropbox', :action => 'upload'
  ###############################################################################################################

  # review urls #################################################################################################
  match '/submit-review' => 'downloads#submit_review', :as => :submit_review
  ###############################################################################################################

  # User upload urls ############################################################################################
  match '/upload' => 'downloads#upload', :as => :upload
  match '/share-app' => 'downloads#share_app', :as => :share_app
  match '/upload-app-1' => 'downloads#upld_basic_app_info', :as => :upload_app1
  match '/upload_app_2(/:app_id/:type)' => 'downloads#upld_app_file', :as => :upload_app2
  match '/upload_app_3(/:app_id)' => 'downloads#upld_app_screenshots', :as => :upload_app3
  match '/upload_app_4' => 'downloads#upld_app_social_details', :as => :upload_app4

  ###############################################################################################################

  # All Music page ##############################################################################################
  match '/music' => 'downloads#all_music', :as => :all_music
  ###############################################################################################################

  # forum urls ##################################################################################################
  resources :topics
  resources :forums
  resources :posts
  match '/posting-response' => 'posts#create', :as => :submit_post
  match '/forum/post/tags/:tag' => 'posts#tag_page_show', :as => :post_tagged
  ###############################################################################################################


  # admin urls ##################################################################################################
  #match '/facebook' => 'facebookapp#index', :as => :fb_index, :canvas => true
  match '/killeradmin' => 'admin#index', :as => :admin
  match '/killeradmin/killer-testing' => 'admin#experiment', :as => :admin_test
  match '/killeradmin/dwnld/edit/:id' => 'admin#dwedit', :as => :admin_dwedit
  match '/killeradmin/notification_mailing' => 'admin#send_notification', :as => :admin_notification_mail
  match '/killeradmin/send_notification_mail' => 'admin#send_notification_mail', :as => :admin_send_notification
  match '/killeradmin/generate_licence' => 'admin#generate_licence', :as => :admin_gen_licence
  match '/killeradmin/licence' => 'admin#licence', :as => :admin_licence
  match '/killeradmin/generate_spam_ids' => 'admin#generate_new_spam_ids', :as => :admin_gen_spam_id
  match '/killeradmin/bulk_apps' => 'admin#add_bulk', :as => :admin_bulk_app
  match '/killeradmin/bulk_apps/submit-single' => 'admin#submit_one_app', :as => :admin_app_submit

  # temp admin urls (Comment out when used)
  # match '/killeradmin/user-to-user-details' => 'admin#migrate_user_details', :as => :admin_migrate_user
  # match '/killeradmin/user-dwld-details' => 'admin#migrate_user_dwld', :as => :admin_migrate_user_dwld
  match '/killeradmin/migrate-fb-user-to-authentication' => 'admin#migrate_fb_users_to_authentication', :as => :admin_migrate_fb_to_auth


  match 'killer-tasks/scheduled/update-daily-count/:pass' => 'task#cron_download_daily', :as => :cron_update_daily_count
  match 'killer-tasks/scheduled/update-weekly-count/:pass' => 'task#cron_download_weekly', :as => :cron_update_weekly_count
  match 'killer-tasks/scheduled/update-monthly-count/:pass' => 'task#cron_download_monthly', :as => :cron_update_monthly_count
  ###############################################################################################################


  # mobile/wap urls #############################################################################################
  match '/m' => 'mobile/base#home', :as => :wap_home
  match '/m/downloads' => 'mobile/downloads#options', :as => :wap_download
  match '/m/all_downloads' => 'mobile/downloads#index', :as => :wap_download_all
  match '/m/downloads/:title' => 'mobile/downloads#show', :as => :wap_download_show
  match '/m/downloads/:title/screenshots' => 'mobile/downloads#screenshots', :as => :wap_download_ss
  match '/m/apps/:category' => 'mobile/base#category', :as => :wap_category
  match '/m/platform/JavaME' => 'mobile/base#javame', :as => :wap_javame
  match '/m/platform/Symbian' => 'mobile/base#symbian', :as => :wap_symbian
  match '/m/platform/BlackBerry' => 'mobile/base#blackberry', :as => :wap_blackberry
  match '/m/platform/Android' => 'mobile/base#android', :as => :wap_android
  match '/m/platform/Windows_Mobile' => 'mobile/base#windows', :as => :wap_windows
  match '/' => 'mobile/base#home', :as => :wap_home1, :subdomain => 'm'
  match '/downloads' => 'mobile/downloads#options', :as => :wap_download1, :subdomain => 'm'
  match '/all_downloads' => 'mobile/downloads#index', :as => :wap_download_all1, :subdomain => 'm'
  match '/downloads/:title' => 'mobile/downloads#show', :as => :wap_download_show1, :subdomain => 'm'
  match '/downloads/:title/screenshots' => 'mobile/downloads#screenshots', :as => :wap_download_ss1, :subdomain => 'm'
  match '/apps/:category' => 'mobile/base#category', :as => :wap_category1, :subdomain => 'm'
  match '/platform/JavaME' => 'mobile/base#javame', :as => :wap_javame1, :subdomain => 'm'
  match '/platform/Symbian' => 'mobile/base#symbian', :as => :wap_symbian1, :subdomain => 'm'
  match '/platform/BlackBerry' => 'mobile/base#blackberry', :as => :wap_blackberry1, :subdomain => 'm'
  match '/platform/Android' => 'mobile/base#android', :as => :wap_android1, :subdomain => 'm'
  match '/platform/Windows_Mobile' => 'mobile/base#windows', :as => :wap_windows1, :subdomain => 'm'
  #################################################################################################################


  # mobile apps urls ##############################################################################################
  match '/worldcup2011' => 'worldcup2011#index', :as => :wc_home
  match '/worldcup2011/comment/new' => 'worldcup2011#new', :as => :wc_new_comment
  match '/worldcup2011/comment/new/submitting' => 'worldcup2011#create', :as => :wc_creat_comment
  match '/worldcup2011/comment/edit/:id' => 'worldcup2011#edit', :as => :wc_edit_comment
  match '/worldcup2011/comment/edit/:id/updating' => 'worldcup2011#update', :as => :wc_update_comment
  match '/worldcup2011/comment/delete/:id' => 'worldcup2011#destroy', :as => :wc_delete_comment
  match '/worldcup2011/comments/feeds/rss' => 'worldcup2011#commentRSS', :as => :wc_comment_rss
  match '/worldcup2011/comment/mobile/:name/:on/:comment' => 'worldcup2011#add_mobile', :as => :wc_comment_mobile, :method => 'POST'

  match '/mnl_missing_code/report/:info' => 'mnl_missing_codes#mobile', :as => :mnl_missing, :method => 'POST'
  match '/mnl_online/mobile/:code' => 'mnl_onlines#mobile', :as => :mnl_online, :method => 'POST'
  match '/mobile_app/share_via_email/:app/:email/:msg' => 'base#share_from_mobile', :as => :mobile_share, :method => 'POST'
  match '/mobile_app/feedback_via_email/:app/:email/:msg' => 'base#feedback_from_mobile', :as => :mobile_feedback, :method => 'POST'
  match '/mobile_app/licence/activation/:code/:imei/:number' => 'base#activating_licence_mobile', :as => :mobile_licence_activation, :method => 'POST'
  ###################################################################################################################

end
