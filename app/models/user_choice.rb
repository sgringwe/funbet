class UserChoice < ParseResource::Body
	fields :user_id, :bet_id, :choice, :delivered

	validates_presence_of :user_id, :bet_id, :choice, :delivered
end

# create a user
user = User.new(:username => "adelevie") user.password = "asecretpassword" user.save #=> true
# after saving, the password is automatically hashed by Parse's server user.password will return the unhashed password when the original 
# object is in memory from a new session, User.where(:username => "adelevie").first.password will return nil check if a user is logged in
User.authenticate("adelevie", "foooo") #=> false
User.authenticate("adelevie", "asecretpassword") #=> #<User...>
