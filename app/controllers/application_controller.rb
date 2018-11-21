class ApplicationController < ActionController::Base


  helper_method :current_user, :logged_in?
  
  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound => e
      @current_user = nil
      session[:user_id] = nil
      flash[:danger] = "Session ended"
      redirect_to root_path
    end
  end
  
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perfom that action"
      redirect_to root_path
    end
  end
  
end
