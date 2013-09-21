class Bet < ParseResource::Base
  fields :id, :loser_task, :start_date, :complete, :public, :is_true,
		:proposition, :user_id

  # validates_presence_of :loser_task, :proposition, :user_id

	def convert_bools!
		if self.complete == '0'
			self.complete = false
		else
			self.complete = true
		end

		if self.public == '0'
			self.public = false
		else
			self.public = true
		end
	end

	def id
		self.objectId
	end

	def users
		UserChoice.where(bet_id: self.id).map { |uc| uc.user }
	end

	def user
		User.find(self.user_id)
	end
end
