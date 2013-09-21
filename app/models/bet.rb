class Bet < ParseResource::Base
  fields :id, :loser_task, :start_date, :complete, :public, :winning_choice,
		:choice_1, :choice_2

  validates_presence_of :loser_task, :choice_1, :choice_2

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
end
