class UserModel {
  final String email;
  final String password;
  final int age;

  const UserModel({
    required this.email,
    required this.password,
    required this.age,
  });

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password, "age": age};
  }

  static UserModel fromJson(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'].toString(),
      password: data['password'].toString(),
      age: data['age'],
    );
  }
}
