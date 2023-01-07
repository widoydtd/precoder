class UserModel {
  String? uid;
  String? username;
  String? fullname;
  String? email;
  String? phone;

  UserModel({this.uid, this.username, this.fullname, this.email, this.phone});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      fullname: map['fullname'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'fullname': fullname,
      'email': email,
      'phone': phone,
    };
  }
}
