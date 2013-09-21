class SessionsController < ApplicationController

  def new

  end

  def create
		puts request.env['omniauth.auth']
    user = User.authenticate(params[:username], params[:password])
    # user = User.authenticate("adelevie", "asecretpassword")
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "logged in !"
      puts 'logged in'
    else
      flash.now.alert = "Invalid username or password"
      render "new"
      puts 'failed'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
