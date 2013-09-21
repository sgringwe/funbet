# app/models/user.rb
class User < ParseUser
  # no validations included, but feel free to add your own
  validates_presence_of :username

  # you can add fields, like any other kind of Object...
  fields :name, :bio

  # but note that email is a special field in the Parse API.
  fields :email

	def id
		self.objectId
	end
end
