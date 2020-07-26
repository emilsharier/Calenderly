class User {
  String email, password, type, name, phone;

  User({this.email, this.password, this.type, this.name, this.phone});

  toJson() => {
        'email': this.email,
        'type': this.type,
        'name': this.name,
        'phone': this.phone
      };

  User.fromJson(Map<String, dynamic> json) {
    this.email = json['email'];
    this.type = json['type'];
    this.name = json['name'];
    this.phone = json['phone'];
  }
}
