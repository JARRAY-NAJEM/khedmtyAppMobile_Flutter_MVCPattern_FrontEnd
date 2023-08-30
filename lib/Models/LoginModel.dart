class LoginModel {
  final String number;
  final String password;

  LoginModel({required this.number, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'password': password,
    };
  }
}
