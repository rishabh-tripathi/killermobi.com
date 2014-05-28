class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    if(!resource.id.nil?)
      user_detail = UserDetail.find_by_user_id(resource.id)
      if(user_detail.nil?)
        ud = UserDetail.new
        ud.user_id = resource.id
        ud.save
      end
    end
    # add custom create logic here
    session[:omniauth] = nil unless @user.new_record?
  end

  def update
    super
  end

  def edit
    super
  end

  def cancel
    super
  end

  private

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
end
