class User < ParseUser
  attr_accessor :id
  fields :email, :phone, :username

  # has_many :bets, :inverse_of => :owner
  # has_many :user_choices, :inverse_of => :user

  validates_presence_of :username

	def id
		self.objectId
	end

	def bets
		UserChoice.where(user_id: self.id).map { |uc| uc.bet }
	end
end
