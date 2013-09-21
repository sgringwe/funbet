class UsersController < ApplicationController
	respond_to :html

	def new
		@user = User.new
		respond_with(@user) # create a user
	end

	def create
		if params[:user][:password] != params[:user][:password_confirmation]
			flash[:error] = 'Passwords do not match'
			@user = User.new(params[:user])
			render 'new'
		else
			user = User.new(params[:user])
			user.save
			redirect_to root_path
		end
	end
end
