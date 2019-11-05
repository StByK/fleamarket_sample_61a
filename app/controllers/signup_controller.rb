class SignupController < ApplicationController
   # 各アクションごとに新規インスタンスを作成し、遷移元のページのデータをsessionに保管
def step1
  @user = User.new 
end

def step2
  # step1で入力された値をsessionに保存
  session[:nickname] = user_params[:nickname]
  session[:email] = user_params[:email]
  session[:password] = user_params[:password]
  session[:password_confirmation] = user_params[:password_confirmation]
  session[:first_name] = user_params[:first_name]
  session[:last_name] = user_params[:last_name]
  session[:first_name_kana] = user_params[:first_name_kana]
  session[:last_name_kana] = user_params[:last_name_kana]
  # session[:birth_year] = user_params[:birth_year]
  # session[:birth_month] = user_params[:birth_month]
  # session[:birth_day] = user_params[:birth_day]

  @user = User.new 
end

def step3
  # step2で入力された値をsessionに保存
  session[:phone_number] = user_params[:phone_number]
  @user = User.new
end

def step4
  @user = User.new
end

def create
  # ＃ここに全部ぶっこむ
  @user = User.new(

  )
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
      :phone_number      #step2
  )
  end
end