class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    auth = request.env["omniauth.auth"]
    session[:uid]      = auth.uid
    session[:provider] = auth.provider
    
    @user = User.find_oauth(request.env["omniauth.auth"])
    if @user != nil
      sign_in_and_redirect @user, event: :authentication 
    else
      redirect_to root_path
      # 仮置
    end
  end

  def failure
    redirect_to root_path and return
  end
end