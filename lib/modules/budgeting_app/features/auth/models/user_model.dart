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
}
