import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khedmty_app/Models/SignModel.dart';
import 'package:khedmty_app/Models/WorkerModel.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import your WorkerModel class

class WorkerController {
  final String apiUrl = 'http://10.0.2.2:3000/worker/id';
  final String apiUrl2 = 'http://10.0.2.2:3000/worker/work';
  final String apiUrl3 = 'http://10.0.2.2:3000/worker/update';
  List<WorkerModel> workers = [];

  Future<WorkerModel> fetchWorkerData(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return WorkerModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Worker data');
    }
  }

  Future<List<WorkerModel>> fetchWorkersByWork(String work) async {
    final response = await http
        .get(Uri.parse('$apiUrl2/$work')); // Replace with your API endpoint

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      workers = jsonData
          .map((workerData) => WorkerModel.fromJson(workerData))
          .where((worker) =>
                  // worker.firstName.toLowerCase().contains(work.toLowerCase()) ||
                  // worker.lastName.toLowerCase().contains(work.toLowerCase()) ||
                  // worker.number.toLowerCase().contains(work.toLowerCase()) ||
                  worker.work.toLowerCase().contains(work.toLowerCase())
              // worker.address.toLowerCase().contains(work.toLowerCase()) ||
              // worker.description.toLowerCase().contains(work.toLowerCase())
              )
          .toList();
      return workers;
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }

  Future<void> updateProfileData({
    required String id,
    required String firstName,
    required String lastName,
    required String password,
    required String number,
    required String work,
    required String address,
    required String description,
  }) async {
    final updateUrl = '$apiUrl3/$id';
    try {
      final response = await http.put(
        Uri.parse(updateUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstName': firstName,
          'lastName': lastName,
          'password': password,
          'number': number,
          'work': work,
          'address': address,
          'description': description,
        }),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<void> deleteWorkerData(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Worker deleted successfully');
    } else {
      print(response.body);
      throw Exception('Failed to delete Worker data');
    }
  }
}
