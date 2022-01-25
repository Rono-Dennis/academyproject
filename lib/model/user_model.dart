class UserModel {
  String? uid;
  String? email;
  String? userName;
  String? dateTime;
  String? imageUrl;
  String? password;

  UserModel({this.uid, this.email, this.userName, this.dateTime, this.imageUrl, this.password});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      dateTime: map['dateTime'],
      imageUrl: map['imageUrl'],
      password: map['password'],

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
      'dateTime' : dateTime,
      'imageUrl' : imageUrl,
      'password' : password,
    };
  }
}
