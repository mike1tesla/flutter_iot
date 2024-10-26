class Login {
  final String username;
  final String password;

  const Login({required this.username, required this.password});

  Login copyWith({String? username, String? password}) {
    return Login(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {'username': this.username, 'password': this.password};
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }
}
