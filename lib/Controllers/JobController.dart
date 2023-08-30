import 'dart:convert';

import 'package:http/http.dart' as http; // Import the http package
import 'package:khedmty_app/Models/JobModel.dart';

class JobController {
  List<Job> _jobs = []; // List to hold the job data

  List<Job> get jobs => _jobs; // Getter for jobs

  Future<void> fetchJobs() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:3000/job')); // Replace with your API endpoint
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> jobs = json.decode(response.body);
      _jobs = jobs.map((item) => Job.fromJson(item)).toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load jobs');
    }
  }
}
