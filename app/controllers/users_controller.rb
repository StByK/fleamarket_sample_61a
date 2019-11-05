class UsersController < ApplicationController

  def index
  end

  def logout
  end

  


  private

  def check_user
    if User.find(params[:id]) != current_user
      flash[:alert] = "権限がありません"
      redirect_to root_path
    end
  end

end