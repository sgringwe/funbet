class UserChoice < ParseResource::Body
	fields :user_id, :bet_id, :choice, :delivered

	validates_presence_of :user_id, :bet_id, :choice, :delivered
end
