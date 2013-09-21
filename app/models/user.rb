class User < ParseUser
  validates_presence_of :username
  attr_accessor :id

  fields :email

	def id
		self.objectId
	end
end
