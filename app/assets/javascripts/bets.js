function UserChoice() {
	this.user_id = ko.observable();
	this.bet_id = ko.observable();
	this.choice = ko.observable();
	this.verification_file = ko.observable();
	this.hasDelivered = ko.observable(null);
}

function BetsViewModel() {
	var self = this;
	self.id = ko.observable();
	self.loser_task = ko.observable();
	self.start_date = ko.observable();
	self.isComplete = ko.observable(false);
	self.isPublic = ko.observable(true);
	self.proposition = ko.observable();

	self.userChoice = new UserChoice()
}
ko.applyBindings(new BetsViewModel());
