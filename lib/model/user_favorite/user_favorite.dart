
class UserFavorite {

	int _id;
	String _name;
	String _location;
	String _email;

	UserFavorite(this._name, this._email, [this._location] );

	UserFavorite.withId(this._id, this._name, this._email, [this._location]);

	int get id => _id;

	String get name => _name;

	String get location => _location;

	String get email => _email;


	set name(String newTitle) {
		if (newTitle.length <= 255) {
			this._name = newTitle;
		}
	}
	set location(String newDescription) {
		if (newDescription.length <= 255) {
			this._location = newDescription;
		}
	}

	set email(String newDate) {
		this._email = newDate;
	}

	// Convert a Note object into a Map object
	Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['name'] = _name;
		map['location'] = _location;
		map['email'] = _email;

		return map;
	}

	// Extract a Note object from a Map object
	UserFavorite.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._name = map['name'];
		this._location = map['location'];
		this._email = map['email'];
	}
}









