class Bet < ParseResource::Base
  fields :id, :loser_task, :isComplete, :is_public,	:proposition, :owner

  # validates_presence_of :loser_task, :proposition, :owner

	def convert_bools!
		if self.isComplete == '0'
			self.isComplete = false
		else
			self.isComplete = true
		end

		if self.isPublic == '0'
			self.isPublic = false
		else
			self.isPublic = true
		end
	end

	def id
		self.objectId
	end

	def users
		UserChoice.where(bet_id: self.id).map { |uc| uc.user }
	end

	def user
		User.find(self.owner)
	end
end
