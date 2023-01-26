class UserModel {
  String? uid;
  String? username;
  String? fullname;
  String? email;
  String? phone;
  String? pfp;

  UserModel({
    this.uid,
    this.username,
    this.fullname,
    this.email,
    this.phone,
    this.pfp,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      fullname: map['fullname'],
      email: map['email'],
      phone: map['phone'],
      pfp: map['pfp'],
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
      'pfp': pfp,
    };
  }
}
