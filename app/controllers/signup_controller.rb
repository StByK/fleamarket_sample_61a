class SignupController < ApplicationController

  def new
    @user = User.new 
  end
  #  各アクションごとに新規インスタンスを作成し、遷移元のページのデータをsessionに保管
  def step1
    @user = User.new 
  end


  def step2
    # step1で入力された値をsessionに保存
    session[:nickname]              = user_params[:nickname]
    session[:email]                 = user_params[:email]
    session[:password]              = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:first_name]            = user_params[:first_name]
    session[:last_name]             = user_params[:last_name]
    session[:first_name_kana]       = user_params[:first_name_kana]
    session[:last_name_kana]        = user_params[:last_name_kana]
    session[:birth_year]            = user_params[:birth_year]
    session[:birth_month]           = user_params[:birth_month]
    session[:birth_day]             = user_params[:birth_day]

    @user = User.new 
  end

  def step3
    # step2で入力された値をsessionに保存
    session[:phone_number]          = user_params[:phone_number]
    @user = User.new
    @user.build_house
    @address = House.new
  end

  def step4
    # step3で入力された値をsessionに保存
    # session[:first_name_house_attributes]           = user_params[:first_name]
    # session[:last_name_house_attributes]            = user_params[:last_name]
    # session[:first_name_kana_house_attributes]      = user_params[:first_name_kana]
    # session[:last_name_kana_house_attributes]       = user_params[:last_name_kana]
    # session[:postal_code_house_attributes]          = user_params[:postal_code]
    # session[:prefecture_id_house_attributes]        = user_params[:prefecture_id]
    # session[:city_house_attributes]                 = user_params[:city]
    # session[:street_name_house_attributes]          = user_params[:street_name]
    # session[:apt_house_attributes]                  = user_params[:apt]
    # session[:phone_number_house_attributes]         = user_params[:phone_number]
    session[:house_attributes] = user_params[:house_attributes]
    @user = User.new
    @user.build_house
  end

  def done
    # step4で入力された値をsessionに保存
    # sign_in User.find(session[:user_id]) unless user_signed_in?

  end


  def create
    # ＃ここに全部ぶっこむ
    @user = User.new(
      nickname:                   session[:nickname],
      email:                      session[:email],
      password:                   session[:password],
      password_confirmation:      session[:password_confirmation],
      first_name:                 session[:first_name],
      last_name:                  session[:last_name],
      first_name_kana:            session[:first_name_kana],
      last_name_kana:             session[:last_name_kana],
      birth_year:                 session[:birth_year],
      birth_month:                session[:birth_month],
      birth_day:                  session[:birth_day],
      phone_number:               session[:phone_number],
    )
    @user.build_house(session[:house_attributes])
    if @user.save
    # ログインするための情報を保管
      session[:user_id] = @user.id
      redirect_to done_signup_index_path
    else
      render step4_signup_index_path
    end
  end

 

  private
    def user_params
      params.require(:user).permit(
        :nickname, 
        :email, 
        :password, 
        :password_confirmation, 
        :last_name, 
        :first_name, 
        :last_name_kana, 
        :first_name_kana,  #step1
        :phone_number,     #step2
        house_attributes:[
          :id,
          :first_name,
          :last_name,
          :first_name_kana,
          :last_name_kana,
          :postal_code,
          :prefecture_id,
          :city,
          :street_name,
          :apt,
          :phone_number  #step3
        ]
    )
    end
  end


