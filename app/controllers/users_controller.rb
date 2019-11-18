class UsersController < ApplicationController
  before_action :check_user

  def show
    @user = User.find(params[:id])
    # @items = Item.where(user_id: @user.id)
  end

  def show2
    @user = User.find(params[:id])
    @items = Item.where(seller_id: current_user.id)
    @dealings = Dealing.where(seller_id: current_user.id)
    @exhibitings = []
    @tradings = []
    @solds = []
    @stops = []
    @dealings.each do |dealing|
      if dealing.status == 1
        @exhibitings << dealing
      elsif dealing.status == 2
        @tradings << dealing
      elsif dealing.status == 3
        @solds << dealing
      else
        @stops << dealing
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def logout
  end

  def identification
    @user = User.find(params[:id])
  end

  private

  def check_user
    if User.find(params[:id]) != current_user
      flash[:alert] = "権限がありません"
      redirect_to root_path
    end
  end

end