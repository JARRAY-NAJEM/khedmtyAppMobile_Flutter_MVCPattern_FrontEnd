import 'dart:convert';

import 'package:http/http.dart' as http; // Import the http package
import 'package:khedmty_app/Models/JobModel.dart';

class JobController {
  List<Job> _jobs = []; // List to hold the job data
  List<Job> _filteredJobs = [];
  List<Job> get jobs => _jobs; // Getter for jobs
  List<Job> get filteredJobs => _filteredJobs;

  // Future<void> fetchJobs() async {
  //   final response = await http.get(Uri.parse(
  //       'http://10.0.2.2:3000/job')); // Replace with your API endpoint
  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     // If the call to the server was successful, parse the JSON
  //     List<dynamic> jobs = json.decode(response.body);
  //     _jobs = jobs.map((item) => Job.fromJson(item)).toList();
  //   } else {
  //     // If that call was not successful, throw an error.
  //     throw Exception('Failed to load jobs');
  //   }
  // }
  Future<List<Job>> fetchJobs() async {
    try {
      final response = await http.get(Uri.parse(
          'http://10.0.2.2:3000/job')); // Replace with your API endpoint
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // If the call to the server was successful, parse the JSON
        List<dynamic> jobs = json.decode(response.body);
        List<Job> jobList = jobs.map((item) => Job.fromJson(item)).toList();
        _jobs = jobList;
        _filteredJobs = List.from(_jobs);
        return jobList; // Return the list of jobs
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      print('Error occurred while fetching jobs: $e');
      return []; // Return an empty list in case of an error
    }
  }

  List<Job> filteredJobsByKeyword(String keyword) {
    if (keyword.isEmpty) {
      // If the keyword is empty, return all jobs
      return jobs;
    } else {
      // Filter jobs that contain the keyword in their job name
      return jobs
          .where((job) => job.job.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
  }
  // Filtering function
  // void filterJobs(String query) {
  //   _filteredJobs = _jobs.where((job) {
  //     // You can customize this condition based on your filtering needs
  //     return job.job.toLowerCase().contains(query.toLowerCase());
  //   }).toList();
  // }
}
