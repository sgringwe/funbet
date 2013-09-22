class Bet < ParseResource::Base
	fields :id, :loser_task, :outcome, :is_public, :proposition, :owner_id, :event_start

	def convert_bools!
		if self.outcome == '0'
			self.outcome = false
		elsif self.outcome == '1'
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

	def betting_allowed
		Time.now < self.event_start
	end

	def user_choice_for(user)
		UserChoice.where(bet_id: self.id, user_id: user.id).first
	end

	def agreeing_choices
		user_choices.where(choice: true)
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
