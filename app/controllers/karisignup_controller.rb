class RegistrationsController < ApplicationController


  #登録方法選択（email, facebook, google）ページ
  def new
  end


  def new1
    @user = User.new
  end

  def create1
    @user = User.new(user_params
                .merge(tel:       "08000000000",
                       customer:  "000",
                       card:      "000"))
    if @user.valid?
      if verify_recaptcha
        session[:email]                 = user_params[:email]
        session[:password]              = user_params[:password]
        session[:password_confirmation] = user_params[:password_confirmation]
        session[:nickname]              = user_params[:nickname]
        session[:firstname]             = user_params[:firstname]
        session[:lastname]              = user_params[:lastname]
        session[:firstname_kana]        = user_params[:firstname_kana]
        session[:lastname_kana]         = user_params[:lastname_kana]
        session[:birthday]              = user_params[:birthday]
        redirect_to new2_registrations_path
      else
        render "new1"
      end
    else
      render "new1"
    end
  end

  #1ページ目（facebook, google専用ページから遷移後の1ページ目）
  def new1_1
    @user = User.new
  end

  def create1_1
    @user = User.new(user_params
                .merge(password:              "000000",
                       password_confirmation: "000000",
                       tel:                   "08000000000",
                       customer:              "000",
                       card:                  "000"))
    if @user.valid?
      if verify_recaptcha
        session[:email]                 = user_params[:email]
        session[:password]              = "000000"
        session[:password_confirmation] = user_params[:password_confirmation]
        session[:nickname]              = user_params[:nickname]
        session[:firstname]             = user_params[:firstname]
        session[:lastname]              = user_params[:lastname]
        session[:firstname_kana]        = user_params[:firstname_kana]
        session[:lastname_kana]         = user_params[:lastname_kana]
        session[:birthday]              = user_params[:birthday]
        redirect_to new2_registrations_path
      else
        render "new1_1"
      end
    else
      render "new1_1"
    end
  end

  #2ページ目
  def new2
    @user = User.new
  end

  def create2
    @user = User.new(user_params
                .merge(email:                 "abc@abc",
                       password:              "000000",
                       password_confirmation: "000000",
                       nickname:              "abc",
                       firstname:             "あああ",
                       lastname:              "あああ",
                       firstname_kana:        "アアア",
                       lastname_kana:         "アアア",
                       birthday:              "1990-01-01",
                       customer:              "000",
                       card:                  "000"))
    if @user.valid?
      session[:tel]  = user_params[:tel]
      redirect_to new4_registrations_path
    else
      render "new2"
    end
  end

  def update_params
    params.require(:user).permit(:nickname, :profile, :icon_image)
  end
