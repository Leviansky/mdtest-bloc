class UserApp {
  final String uid;
  final String name;
  final String email;
  final bool isEmailVerified;

  UserApp({
    required this.uid,
    required this.name,
    required this.email,
    required this.isEmailVerified,
  });

  factory UserApp.fromFirestore(String id, Map<String, dynamic> json) {
    return UserApp(
      uid: id,
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      isEmailVerified: (json['isEmailVerified'] ?? false) as bool,
    );
  }
}
