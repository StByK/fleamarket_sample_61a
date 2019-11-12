class UsersController < ApplicationController
  before_action :check_user

  def show
    @user = User.find(params[:id])
    # @items = Item.where(user_id: @user.id)
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