# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  # callback for facebook
  def facebook
    callback_for(:facebook)
  end

  # callback for google
  def google_oauth2
    callback_for(:google)
  end

  # common callback method
  def callback_for(provider)
    user_info = User.find_omniauth(request.env["omniauth.auth"])
    
    @user = user_info[:user]
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      sns_id = user_info[:sns_id]
      @credential = @user.sns_credentials.build(uid: sns_id.uid, provider: sns_id.provider)
      render template: "devise/registrations/new"
    end
  end

  def failure
    redirect_to root_path
  end
  
end