class UsersController < ApplicationController
	respond_to :html

	before_filter :authenticate_user!, only: :edit

	def new
		@user = User.new
		respond_with(@user) # create a user
	end

	def edit
		@user = User.find(params[:id])
		respond_with(@user) # Edit user account
	end

	def show
		@user = User.find(params[:id])
		respond_with(@user) # Edit user account
	end

	def update
		@user = User.find(params[:id])
		@user.update_attributes(params[:user])
    @user.save
    redirect_to bets_path
	end

	def create
		if params[:user][:password] != params[:user][:password_confirmation]
			flash[:error] = 'Passwords do not match'
			@user = User.new(params[:user])
			render 'new'
		else
			params.delete(:password_confirmation)
			user = User.new(params[:user])
			user.save
			flash[:success] = 'Successfully registered'
			redirect_to login_path
		end
	end
end
