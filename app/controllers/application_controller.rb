class ApplicationController < ActionController::Base
  
  before_filter RubyCAS::Filter
  before_filter :current_user
  before_filter :first_time_user

  helper_method :current_user

  #rescue_from CanCan::AccessDenied do |exception|

  def current_user
    @current_user ||= User.where(login: session[:cas_user]).first if session[:cas_user]
  end

  def first_time_user
    if current_user.nil?
      flash[:notice] = "Hey there! Since this is your first time logging in, we'll
        need you to supply us with some basic contact information."
      redirect_to new_user_path
    end
  end

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
end
