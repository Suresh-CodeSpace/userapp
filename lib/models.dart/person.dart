class Person {
  int _id;
  String _first_name;
  String _last_name;
  String _email;
  Person(this._id, this._first_name, this._last_name, this._email);

  int get id => id;
  String get first_name => _first_name;
  String get last_name => _last_name;
  String get email => _email;

  set first_name(String newfirstname) {
    if (newfirstname.length <= 255) {
      this._first_name = newfirstname;
    }
  }

  set last_name(String newlastname) {
    if (newlastname.length <= 255) {
      this._last_name = newlastname;
    }
  }

  set email(String newemail) {
    if (newemail.length <= 255) {
      this._email = newemail;
    }
  }

  // factory Person.fromMap(Map<String, dynamic> json) => new Person(
  //       _id: json["id"],
  //       _first_name: json["first_name"],
  //       _last_name: json["last_name"],
  //       _email: json["email"],
  //     );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = _id;
    }
    map["first_name"] = _first_name;
    map["last_name"] = _last_name;
    map["email"] = _email;
    return map;
  }


Person.fromMapObject(Map<String,dynamic>map){

  this._id = map['id'];
  this._first_name = map['first_name'];
  this._last_name = map['last_name'];
  this._email = map['email'];
}


}
