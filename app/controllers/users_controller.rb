class UsersController < ApplicationController
	respond_to :html
	def new
                respond_with(@new) # create a user
		user = User.new(:username => params[:username])
		user.password = params[:pwd]
		user.save #=> true
	end
	# # after saving, the password is automatically hashed by Parse's server user.password will return the unhashed password when the original 
    	# # object is in memory from a new session, User.where(:username => "adelevie").first.password will return nil check if a user is logged in
end
