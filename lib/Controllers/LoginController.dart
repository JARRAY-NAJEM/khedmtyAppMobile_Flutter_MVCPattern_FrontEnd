import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:khedmty_app/Models/LoginModel.dart';

class LoginController {
  Future<String?> login(LoginModel loginModel) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginModel.toJson()),
    );
    // Print response body for debugging

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseData = response.body;

      return responseData; // Login successful, no error
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
