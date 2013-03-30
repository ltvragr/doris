class ApplicationController < ActionController::Base
  
  before_filter RubyCAS::Filter

#### DEVELOPMENT ####
  before_filter :impersonate_user   #impersonate user code
#### DEVELOPMENT ####
  
  before_filter :current_user
  before_filter :first_time_user

  helper_method :current_user

  #rescue_from CanCan::AccessDenied do |exception|

#### DEVELOPMENT ####
  def impersonate_user
    session[:impers] = params[:impers] if params[:impers]

    if session[:impers]
      @current_user = User.where(login: session[:impers]).first
    end 
  end
#### DEVELOPMENT ####

  def current_user
      @current_user ||= User.where(login: session[:cas_user]).first if session[:cas_user]
  end

  def first_time_user
    if current_user.nil?
      flash[:notice] = "Hey there! Since this is your first time logging in, we'll
        need you to supply us with some basic contact information."
      redirect_to new_user_path
    elsif current_user.is_active == false
      flash[:notice] = "Hey there! Since this is your first time logging in, we'll need you to verify your contact information"
      redirect_to edit_user_path(current_user.id)
    end
  end

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    if current_user.nil?
      redirect_to new_user_path
    else
      redirect_to home_url
    end
  end
end
