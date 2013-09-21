class User < ParseUser
  attr_accessor :id

  fields :email, :phone, :username

  validates_presence_of :username

	def id
		self.objectId
	end
end
