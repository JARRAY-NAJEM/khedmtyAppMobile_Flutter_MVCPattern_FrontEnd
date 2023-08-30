class SignModel {
  final String firstName;
  final String lastName;
  final String password;
  final String number;
  final String work;
  final String address;
  final String description;

  SignModel(
      {required this.firstName,
      required this.lastName,
      required this.password,
      required this.number,
      required this.work,
      required this.address,
      required this.description});

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'number': number,
      'work': work,
      'address': address,
      'description': description,
    };
  }
}
