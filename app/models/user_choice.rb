class UserChoice < ParseResource::Base
	fields :user_id, :bet_id, :choice, :verification_file, :has_delivered

  # This made it break
	# validates_presence_of :user_id, :bet_id, :choice

	def user
		User.find(self.user_id)
	end

	def bet
		Bet.find(self.bet_id)
	end
end
