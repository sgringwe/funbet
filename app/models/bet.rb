class Bet < ParseResource::Base
	fields :id, :loser_task, :outcome, :is_public, :proposition, :owner_id

	def convert_bools!
		if self.outcome == '0'
			self.outcome = false
		else
			self.outcome = true
		end

		if self.is_public == '0'
			self.is_public = false
		else
			self.is_public = true
		end
	end

	def id
		self.objectId
	end

	def disagreeing_choices
		user_choices.where(choice: false)
	end

	def users
		user_choices.map { |uc| uc.user }
	end

	def user_choices
		UserChoice.where(bet_id: self.id)
	end

	def owner
		User.find(self.owner_id)
	end
end
