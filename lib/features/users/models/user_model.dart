class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String? photoUrl;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    this.photoUrl,
  });

  factory UserModel.frommap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photourl'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullname': fullName,
      'email': email,
      'photourl': photoUrl,
    };
  }
}
