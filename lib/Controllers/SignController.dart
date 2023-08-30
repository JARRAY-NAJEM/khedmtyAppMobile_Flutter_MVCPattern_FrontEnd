import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:khedmty_app/Models/SignModel.dart';

class SignController {
  Future<String?> signup(SignModel signModel) async {
    final response = await http.post(
      Uri.parse(
          'http://10.0.2.2:3000/worker'), // Replace with your signup endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(signModel.toJson()),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return null; // Signup successful, no error
    } else if (response.statusCode == 401) {
      // Parse error message from JSON response
      Map<String, dynamic> responseData = json.decode(response.body);
      String errorMessage = responseData['message'];
      return errorMessage;
    } else {
      return 'An error occurred. Please try again later.';
    }
  }
}
