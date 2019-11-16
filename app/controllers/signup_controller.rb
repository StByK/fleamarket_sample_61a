class SignupController < ApplicationController

  def new
    @user = User.new 
  end
  
  def step1
    @user = User.new 
  end

  def step2
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
    session[:phone_number]          = user_params[:phone_number]
    @user = User.new
    @user.build_house
  end

  def step4
    #使う可能性あり
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
    # session[:house_attributes] = user_params[:house_attributes]
    # @user = User.new
    # @user.build_house
  end


  def done
    sign_in User.find(session[:user_id]) unless user_signed_in?

  end


  def create
    session[:house_attributes] = user_params[:house_attributes]
    @user = User.new
    @user.build_house
    
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
      phone_number:               session[:phone_number]
    )
    @user.build_house(session[:house_attributes])
    

    if @user.save
    #ログインするための情報を保管
    #ここでidをsessionに入れることでログイン状態に持っていける。
    #ログイン状態維持のためuser_idをsessionに保存
    session[:user_id] = @user.id
    redirect_to step4_signup_index_path
    else
    render step3_signup_index_path
    end
    sign_in User.find(session[:user_id]) unless user_signed_in?

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
        :first_name_kana,
        :birth_year,
        :birth_month,
        :birth_day,  
        :phone_number,     
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
          :phone_number 
        ]
    )
    end
  end



  # # -----------------------------------------------------------

#   def new
#     @user = User.new 
#   end



#   #1ページ目（email）
#   def step1
#     @user = User.new
#   end

#   def create1
#     @user = User.new
#     # (user_params.merge(phone_number:       "08000000000", 
#     #                    customer:  "000", 
#     #                    card:      "000"))
#     if @user.valid?
#         session[:email]                 = user_params[:email] 
#         session[:password]              = user_params[:password] 
#         session[:password_confirmation] = user_params[:password_confirmation] 
#         session[:nickname]              = user_params[:nickname]
#         session[:firstname]             = user_params[:firstname]
#         session[:lastname]              = user_params[:lastname]
#         session[:firstname_kana]        = user_params[:firstname_kana]
#         session[:lastname_kana]         = user_params[:lastname_kana]
#         session[:birth_day]             = user_params[:birth_day]
#         session[:birth_month]           = user_params[:birth_month]
#         session[:birth_year]            = user_params[:birth_year]

#         redirect_to step2_signup_index_path
#       else
#         render "step1"
#       end  
#   end


#   #2ページ目
#   def step2 
#     @user = User.new 
#   end

#   def create2
#     @user = User.new(user_params.merge(
#                        email:                 "abc@abc", 
#                        password:              "000000", 
#                        password_confirmation: "000000", 
#                        nickname:              "abc", 
#                        firstname:             "あああ", 
#                        lastname:              "あああ", 
#                        firstname_kana:        "アアア", 
#                        lastname_kana:         "アアア",  
#                        birth_day:              "01",
#                        birth_month:           "01",
#                        birth_year:            "2000"       
#                        ))
#     if @user.valid?
#       session[:phone_number]  = user_params[:phone_number] 
#       redirect_to step3_signup_index_path
#     else
#       render "step2"
#     end
#   end

#    #4ページ目
#    def step3
#     @user = User.new 
#     @user.build_house
#     @address = House.new
#    end

#   def create3
#     @user = User.new(user_params)
#     @address = House.new(user_params[:house_attributes].merge(user_id: User.first.id)) #user_idは既存データを仮データとして使用
#     if @address.valid? 
#       session[:id]              = user_params[:address_attributes][:id]
#       session[:postal_code]     = user_params[:address_attributes][:postal_code]
#       session[:prefecture_id]   = user_params[:address_attributes][:prefecture_id]
#       session[:city]            = user_params[:address_attributes][:city]
#       session[:address_number]  = user_params[:address_attributes][:address_number]
#       session[:building_name]   = user_params[:address_attributes][:building_name] 
#       redirect_to step4_signup_index_path
#     else
#       render "step3"
#     end
#   end


#     private
#     def user_params
#       params.require(:user).permit(
#         :nickname, 
#         :email, 
#         :password, 
#         :password_confirmation, 
#         :last_name, 
#         :first_name, 
#         :last_name_kana, 
#         :first_name_kana,  #step1
#         :phone_number,     #step2
#         house_attributes:[
#           :id,
#           :first_name,
#           :last_name,
#           :first_name_kana,
#           :last_name_kana,
#           :postal_code,
#           :prefecture_id,
#           :city,
#           :street_name,
#           :apt,
#           :phone_number  #step3
#         ]
#     )
#     end
# end