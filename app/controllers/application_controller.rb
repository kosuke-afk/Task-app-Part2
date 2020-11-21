class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  #ログインしているユーザーのみ認可する機能
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to root_url
    end
  end
  
  #管理者のみ認可する機能
  def admin_user
    unless current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end
  
  #ログインしているユーザー本人のみ認可する機能
  def correct_user
    unless current_user?(@user)
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end
  
  #管理者かログインしている本人のみ認可する機能
  def correct_or_admin
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end
end
