require 'dropbox_sdk'

APP_KEY = "s82wd53181plera"
APP_SECRET = "7wk4kdmxu81zfn2"
ACCESS_TYPE = :app_folder #The two valid values here are :app_folder and :dropbox
                          #The default is :app_folder, but your application might be
                          #set to have full :dropbox access.  Check your app at
                          #https://www.dropbox.com/developers/apps

class DropboxController < ApplicationController
  before_filter :login_required # Adding dropbox space is limited for registered users only

  def authorize
    if not params[:oauth_token] then
      dbsession = DropboxSession.new(APP_KEY, APP_SECRET)
      session[:dropbox_session] = dbsession.serialize #serialize and save this DropboxSession
      #pass to get_authorize_url a callback url that will return the user here
      redirect_to dbsession.get_authorize_url url_for(:action => 'authorize')
    else
      # the user has returned from Dropbox
      dbsession = DropboxSession.deserialize(session[:dropbox_session])
      dbsession.get_access_token  #we've been authorized, so now request an access_token
      logged_in_user.user_detail.update_attribute(:dropbox_session, dbsession.serialize)
      logged_in_user.update_attribute(:default_storage, UploadedFile::STORAGE_DROPBOX)
      client = DropboxClient.new(dbsession, ACCESS_TYPE)
      UploadedFile::FILE_CAT_NAMES.each do|key, value|
        resp = client.file_create_folder("/#{value}")
      end
      redirect_to upload_url # I will change this later
    end
  end

  def upload
    # Check if user has no dropbox session...re-direct them to authorize
    # #### Rishabh change
    # return redirect_to(:action => 'authorize') unless session[:dropbox_session]

    dbsession = DropboxSession.deserialize(logged_in_user.user_detail.dropbox_session)
    client = DropboxClient.new(dbsession, ACCESS_TYPE) #raise an exception if session not authorized
    info = client.account_info # look up account information

    if request.method != "POST"
      # show a file upload page
      folder_metadata = client.metadata('/')
      print "metadata:", folder_metadata
      logger.info("\n\n\n\n== #{folder_metadata.to_yaml}\n\n\n\n")

      folder_metadata = client.metadata('/killermobi device first cut.png')
      print "metadata:", folder_metadata
      logger.info("\n\n\n\n== #{folder_metadata.to_yaml}\n\n\n\n")

      out = client.get_file('/05 Life Is Crazy.mp3')
      logger.info("\n\n\n\n#{out.class}\n\n\n\n")

      file = open('dd.mp3', 'wb')
      file.write(out)
      file.close

      render :inline =>
        "#{info['email']} <br/><%= form_tag({:action => :upload}, :multipart => true) do %><%= file_field_tag 'file' %><%= submit_tag %><% end %>"
      return
    else
      # upload the posted file to dropbox keeping the same name
      resp = client.put_file(params[:file].original_filename, params[:file].read)
      render :text => "Upload successful! File now at #{resp['path']}"
    end
  end
end
