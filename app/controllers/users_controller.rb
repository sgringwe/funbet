def UsersController
  def create
    # create a user
    user = User.new(:username => params[:username]) 
    user.password = params[:password]
    user.save #=> true
    # # after saving, the password is automatically hashed by Parse's server user.password will return the unhashed password when the original 
    # # object is in memory from a new session, User.where(:username => "adelevie").first.password will return nil check if a user is logged in
  end
end
