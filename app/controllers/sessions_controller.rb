require 'curb'

class SessionsController < ApplicationController

  def new

  end

  def create
		if request.env['omniauth.auth']
			data = request.env['omniauth.auth']

			obj = { 'authData' => { 'facebook' => {
				'id' => data.uid,
				'access_token' => data.credentials.token,
				'expiration_date' => Time.at(data.credentials.expires_at)
					.strftime("%Y-%m-%dT%I:%M:%S.000Z")
			}}}

			if current_user
				uri = "https://api.parse.com/1/users/#{current_user.id}"
			else
				uri = 'https://api.parse.com/1/users'
			end
			c = Curl::Easy.new(uri)
			c.headers['X-Parse-Application-Id'] = '0iy7OGpbCzG28sXgOsHbPxEg8ifTKNUzSR4rshIz'
			c.headers['X-Parse-REST-API-Key'] = 'x2qJ5VmWfR9vzmJRxVQjYhfNncd851N8aJxrapwQ'
			if current_user
				c.headers['X-Parse-Session-Token'] = current_user.attributes['sessionToken']
			end
			c.headers['Content-Type'] = 'application/json'
			if current_user
				c.http_post(obj.to_json)
			else
				c.http_put(obj.to_json)
			end

			json = JSON.parse(c.body_str)
			if json.username
				set_current_user(json)
				redirect_to root_url, :notice => "Logged in!"
			else
				flash.now.alert = 'Error logging in'
				render 'new'
			end
		else
			user = User.authenticate(params[:username], params[:password])
			if user
				session[:user_id] = user.id
				redirect_to root_url, :notice => "Logged in!"
			else
				flash.now.alert = "Invalid username or password"
				render 'new'
			end
		end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
