class ApplicationController < ActionController::Base
  protect_from_forgery

	def authenticate_user!
		redirect_to login_path unless current_user
	end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

	def set_current_user(user)
		@current_user = User.new(user)
		session[:user_id] = @current_user.id
	end

  def get_random_photo
    ['/assets/default_user.jpg','/assets/default_user2.jpg',
        '/assets/default_user3.jpg','/assets/default_user4.jpg',
        '/assets/default_user5.jpg','/assets/default_user6.jpg',
        '/assets/default_user7.jpg'].sample
  end

  helper_method :current_user, :set_current_user, :get_random_photo
end
