
class userModel {
  String? uid;
  String? email;
  String? username;
  String? dob;

userModel({this.uid, this.email, this.username, this.dob});


factory userModel.fromMap(map){
  return userModel(
    uid: map['uid'],
    email: map['email'],
    username: map['username'],
    dob: map['dob'],
  );
}

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'dob': dob,
    };
  }






}