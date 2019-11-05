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


  class RegistrationsController < ApplicationController
    before_action :search_preparation, only:[:edit, :update]

    #新規会員登録（5ページ目にあたるcreate5でテーブルにデータ登録完了。それまではsessionで一時保存）

    #登録方法選択（email, facebook, google）ページ
    def new
    end

    #1ページ目（email）
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

    #3ページ目
    def new3
      @user = User.new
    end

    def create3
      redirect_to new4_registrations_path
    end

    #4ページ目
    def new4
      @user = User.new
      @user.build_address
      @address = Address.new
    end

    def create4
      @user = User.new(user_params)
      @address = Address.new(user_params[:address_attributes].merge(user_id: User.first.id)) #user_idは既存データを仮データとして使用
      if @address.valid?
        session[:id]              = user_params[:address_attributes][:id]
        session[:postal_code]     = user_params[:address_attributes][:postal_code]
        session[:prefecture_id]   = user_params[:address_attributes][:prefecture_id]
        session[:city]            = user_params[:address_attributes][:city]
        session[:address_number]  = user_params[:address_attributes][:address_number]
        session[:building_name]   = user_params[:address_attributes][:building_name]
        redirect_to new5_registrations_path
      else
        render "new4"
      end
    end

    #5ページ目
    def new5
      @user = User.new
    end

    def create5
      respond_to do |format|
        format.html {
          require 'payjp'
          Payjp.api_key = Rails.application.credentials.payjp_secret_key
          response_customer = Payjp::Customer.create(card: params[:token])
          session[:customer] = response_customer.id
          session[:card] = response_customer.default_card

          user = User.create(
                  email:          session[:email],
                  password:       session[:password],
                  nickname:       session[:nickname],
                  firstname:      session[:firstname],
                  lastname:       session[:lastname],
                  firstname_kana: session[:firstname_kana],
                  lastname_kana:  session[:lastname_kana],
                  birthday:       session[:birthday] ,
                  tel:            session[:tel],
                  customer:       session[:customer],
                  card:           session[:card],
                  address_attributes:{id:            session[:id],
                                      postal_code:   session[:postal_code],
                                      prefecture_id: session[:prefecture_id],
                                      city:          session[:city],
                                      address_number:session[:address_number],
                                      building_name: session[:building_name]})

          if (session[:uid] != nil) && (session[:provider] != nil)
            SnsCredential.create(
              uid:      session[:uid],
              provider: session[:provider],
              user_id:  user.id)
          end
          session[:uid] = nil
          session[:provider] = nil

          sign_in User.find(user.id) unless user_signed_in?
          redirect_to new6_registrations_path
        }
      end
    end

    #6ページ目
    def new6
    end


    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.valid_password?(user_params[:password]) && @user.update(user_params)
        flash[:success] = "編集しました"
        sign_in User.find(params[:id]) unless user_signed_in?
        redirect_to edit_registration_path(@user)
      else
        flash[:alert] = "入力内容に不備があります"
        render 'edit'
      end
    end

    private

    def user_params
      params.require(:user)
      .permit(:email,
              :password,
              :password_confirmation,
              :nickname,
              :firstname,
              :lastname,
              :firstname_kana,
              :lastname_kana,
              :birthday,
              :tel,
              :icon_image,
              :profile,
              address_attributes:[:id,
                                  :postal_code,
                                  :prefecture_id,
                                  :city,
                                  :address_number,
                                  :building_name])
    end

    def update_params
      params.require(:user).permit(:nickname, :profile, :icon_image)
    end







    


      # 4ページ目

      def create5
        respond_to do |format|
          format.html {
            require 'payjp'
            Payjp.api_key = Rails.application.credentials.payjp_secret_key
            response_customer = Payjp::Customer.create(card: params[:token])
            session[:customer] = response_customer.id
            session[:card] = response_customer.default_card

            user = User.create(
                    email:          session[:email],
                    password:       session[:password],
                    nickname:       session[:nickname],
                    firstname:      session[:firstname],
                    lastname:       session[:lastname],
                    firstname_kana: session[:firstname_kana],
                    lastname_kana:  session[:lastname_kana],
                    birthday:       session[:birthday] ,
                    tel:            session[:tel],
                    customer:       session[:customer],
                    card:           session[:card],
                    address_attributes:{id:            session[:id],
                                        postal_code:   session[:postal_code],
                                        prefecture_id: session[:prefecture_id],
                                        city:          session[:city],
                                        address_number:session[:address_number],
                                        building_name: session[:building_name]})

            if (session[:uid] != nil) && (session[:provider] != nil)
              SnsCredential.create(
                uid:      session[:uid],
                provider: session[:provider],
                user_id:  user.id)
            end
            session[:uid] = nil
            session[:provider] = nil

            sign_in User.find(user.id) unless user_signed_in?
            redirect_to new6_registrations_path
          }
        end
      end
