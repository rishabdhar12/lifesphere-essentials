class UserModel {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final bool emailVerified;

  UserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    this.emailVerified = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'emailVerified': emailVerified,
    };
  }

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      emailVerified: json['emailVerified'] as bool? ?? false,
    );
  }
}
