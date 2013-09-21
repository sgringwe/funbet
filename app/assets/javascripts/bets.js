function UserChoice() {
	this.user_id = ko.observable();
	this.bet_id = ko.observable();
	this.choice = ko.observable();
	this.verification_file = ko.observable();
	this.hasDelivered = ko.observable(false);
}

function BetsViewModel() {
	var self = this;
	self.id = ko.observable();
	self.loser_task = ko.observable();
	self.start_date = ko.observable();
	self.outcome = ko.observable(false);
	self.is_public = ko.observable(true);
	self.proposition = ko.observable();
	self.userChoices = ko.observableArray([]);
	
	self.addUserChoices = function() {
		self.userChoices.push(new UserChoice());
	};
	self.removeUserChoices = function(UserChoice) {
		self.userChoices.remove(UserChoice);
	};
}
ko.applyBindings(new BetsViewModel());
