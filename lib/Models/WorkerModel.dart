class WorkerModel {
  final String firstName;
  final String lastName;
  final String password;
  final String number;
  final String work;
  final String address;
  final String description;

  WorkerModel({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.number,
    required this.work,
    required this.address,
    required this.description,
  });
  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'],
      number: json['number'],
      work: json['work'],
      address: json['address'],
      description: json['description'],
    );
  }
}
