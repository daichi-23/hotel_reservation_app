class UsersController < ApplicationController
  def show
    @user = current_user
  end
  
  def profile
    @user = current_user
  end

  def profile_edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "プロフィール情報が変更されました。"
      redirect_to users_profile_path(@user)
    else
      flash[:alert] = "プロフィール情報の変更に失敗しました。"
      render :profile_edit
    end
  end

  def dummy
    redirect_back(fallback_location: root_path)
  end

  def user_params
    params.require(:user).permit(:name, :image, :introduction, :image_cache, :remove_image)
  end
end
