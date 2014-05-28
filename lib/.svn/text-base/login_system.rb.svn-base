module LoginSystem

protected

def is_logged_in?
  @logged_in_user = current_user if current_user
  @logged_in_user ? @logged_in_user : false
end

def logged_in_user
  return @logged_in_user if is_logged_in?
end

def logged_in_user=(user)
  if !user.nil?
    session[:user] = user.id
    @logged_in_user = user
  end
end

def self.included(base)
  base.send :helper_method, :is_logged_in?, :logged_in_user
end

def check_role(role)
  unless is_logged_in? && @logged_in_user.has_role?(role)
    flash[:error] = "You do not have the permission to do that."
    redirect_to :controller => 'sessions', :action => 'new'
  end
end

def check_administrator_role
  check_role('Administrator')
end

def login_required
  unless is_logged_in?
    flash[:error] = "You must be logged in to do that."
    redirect_to :controller => 'sessions', :action => 'new'
  end
end

def check_editor_role
  check_role('Editor')
end


def login_required
  unless is_logged_in?
    respond_to do |wants|
      wants.html do
        flash[:error] = "You must be logged in to do that."
        redirect_to :controller => 'sessions', :action => 'new'
      end
        wants.xml do
        headers["Status"] = "Unauthorized"
        headers["WWW-Authenticate"] = %(Basic realm="Web Password")
        render :text => "Could't authenticate you",
        :status => '401 Unauthorized',
        :layout => false
      end
    end
  end
end

def check_role(role)
  unless is_logged_in? && @logged_in_user.has_role?(role)
    respond_to do |wants|
      wants.html do
        flash[:error] = "You do not have the permission to do that."
        redirect_to :controller => 'sessions', :action => 'new'
      end
        wants.xml do
        headers['Status'] = 'Unauthorized'
        headers['WWW-Authenticate'] = %(Basic realm="Password")
        render :text => "Insuffient permission",
        :status => '401 Unauthorized',
        :layout => false
      end
    end
  end
end

def check_moderator_role
  check_role('Moderator')
end

end
