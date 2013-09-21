class User < ParseUser
  validates_presence_of :username

  fields :email

	def id
		self.objectId
	end
end
