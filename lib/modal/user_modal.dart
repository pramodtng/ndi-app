class UserModal {
  String? uid;
  String? username;
  String? email;

  UserModal({this.uid, this.username, this.email});

  factory UserModal.fromMap(map) {
    return UserModal(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
    };
  }
}

