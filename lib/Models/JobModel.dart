class Job {
  final int id;
  final String job;
  final String image;

  Job({
    required this.id,
    required this.job,
    required this.image,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      job: json['job'],
      image: json['image'],
    );
  }
}
