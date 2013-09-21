class Bet < ParseResource::Base
  fields :id, :loser_task, :start_date, :complete, :public, :winning_choice,
		:choice_1, :choice_2

  validates_presence_of :title, :loser_task, :complete, :public,
		:winning_choice, :choice_1, :choice_2
end
