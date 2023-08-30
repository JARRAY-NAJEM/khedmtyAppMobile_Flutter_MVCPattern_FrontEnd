import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:khedmty_app/Controllers/LoginController.dart';
import 'package:khedmty_app/Models/LoginModel.dart';
import 'package:khedmty_app/Views/Components/alreadyAccount.dart';
import 'package:khedmty_app/Views/Constants.dart';
import 'package:khedmty_app/Views/Components/Responsive.dart';
import 'package:khedmty_app/Views/Screens/Job/JobsScreen.dart';
import 'package:khedmty_app/Views/Screens/Worker/WorkerScreen.dart';
import 'package:khedmty_app/Views/Screens/SignUp/SignScreen.dart';
import 'package:khedmty_app/Views/Screens/Welcome/welcomeScreen.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = LoginController();
  void _authLogin() async {
    final number = _numberController.text;
    final password = _passwordController.text;

    final loginModel = LoginModel(number: number, password: password);

    try {
      final errorMessage = await _loginController.login(loginModel);

      if (errorMessage == null) {
        // Login successful, navigate to jobsPage
        print("success");
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => JobsPage()),
        // );
        // Navigator.pushNamed(
        //   context,
        //   '/job',
        //   arguments: {'key': 'value'},
        // );
      } else {
        // Display error message from server
        QuickAlert.show(
          context: context,
          title: 'Login Failed',
          text: errorMessage,
          type: QuickAlertType.error,
        );
      }
    } catch (_) {
      // Handle any exceptions that may occur during login
      showDialog(
        context: context,
        builder: (context) => _buildErrorDialog('An error occurred'),
      );
    }
  }

  Widget _buildErrorDialog(String errorMessage) {
    return AlertDialog(
      title: const Text('Login Failed'),
      content: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _numberController =
      TextEditingController(text: '22835484');
  final TextEditingController _passwordController =
      TextEditingController(text: 'admin');
  bool _passwordObscureText = true;
  // final String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // Text(
                    //   "LOGIN",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    const SizedBox(height: defaultPadding * 2),
                    Row(
                      children: [
                        const Spacer(),
                        Expanded(
                          flex: 8,
                          child: SvgPicture.asset("assets/icons/login.svg"),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: defaultPadding * 2),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: Form(
                        key: _formKey,
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _numberController,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: kPrimaryColor,
                                  onSaved: (email) {},
                                  decoration: const InputDecoration(
                                    hintText: "Your Number",
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(defaultPadding),
                                      child: Icon(Icons.person),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'ادخل رقم هاتفك';
                                    } else if (!RegExp(r'^\+?\d{8,12}$')
                                        .hasMatch(value)) {
                                      return 'رقمك غالط';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    textInputAction: TextInputAction.done,
                                    obscureText: _passwordObscureText,
                                    cursorColor: kPrimaryColor,
                                    decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _passwordObscureText =
                                                !_passwordObscureText;
                                          });
                                        },
                                        child: Icon(
                                          color: const Color(0xFF6F35A5),
                                          _passwordObscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      ),
                                      hintText: "Your password",
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.all(defaultPadding),
                                        child: Icon(Icons.lock),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ماتخليهاش فارغة';
                                      }
                                      // else if (value.length < 8) {
                                      //   return 'كلمة السر قصيرة';
                                      // }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),
                                // Hero(
                                //   tag: "login_btn",
                                //   child:
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const WelcomeScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "تسجيل الدخول".toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                // ),
                                const SizedBox(height: defaultPadding),
                                AlreadyAccount(
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const SignUpScreen();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//!----------------------------------------------------------------

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({Key? key}) : super(key: key);

  @override
  _MobileLoginScreenState createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  final LoginController _loginController = LoginController();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _numberController =
      TextEditingController(text: "22835484");
  final TextEditingController _passwordController =
      TextEditingController(text: "admin");

  //!--------------------------
  bool _passwordObscureText = true;
  String _numberValue = '';
  String _passwordValue = '';
  String _id = '';

  //!--------------------------

  void _authLogin() async {
    final number = _numberController.text;
    final password = _passwordController.text;

    final loginModel = LoginModel(number: number, password: password);

    try {
      final response = await _loginController.login(loginModel);

      if (response != null && response.contains("Invalid ") ||
          response!.contains("error")) {
        print(response);
      } else {
        print(response);
        // final parsedResponse = json.decode(response);
        // final _id = parsedResponse['id'].toString();
        // print(_id);
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('_id', _id);

        // print("Saved _id to SharedPreferences: $_id");
        _localStorageID(response);
        _localStorageLogin();
        _loadSavedValue();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return JobsScreen();
            },
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
  //!--------------------------

  void _localStorageID(String response) async {
    final parsedResponse = json.decode(response);
    final _id = parsedResponse['id'].toString();
    // print(_id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', _id);
  }
  //!--------------------------

  void _localStorageLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('number', _numberController.text);
    await prefs.setString('password', _passwordController.text);
  }

  void _loadSavedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _numberValue = prefs.getString('number') ?? '';
      _passwordValue = prefs.getString('password') ?? '';
      _id = prefs.getString('id') ?? '';
    });
    // print(_numberValue);
    // print(_passwordValue);
    print("_loadSavedValue");
    print("_ID: $_id");
    print("_numberValue: $_numberValue");
    print("_passwordValue: $_passwordValue");
  }
  //!--------------------------

  @override
  void initState() {
    super.initState();
    _loadSavedValue();
    // _loadSavedWorker();
  }
  //!--------------------------

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                // Text(
                //   "LOGIN",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                const SizedBox(height: defaultPadding * 2),
                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 8,
                      child: SvgPicture.asset("assets/icons/login.svg"),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: defaultPadding * 2),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 9,
                  child: Form(
                    key: _formKey,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _numberController,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              cursorColor: kPrimaryColor,
                              onSaved: (email) {},
                              decoration: const InputDecoration(
                                hintText: "Your Number",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.person),
                                ),
                              ),
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'ادخل رقم هاتفك';
                              //   } else if (!RegExp(r'^\+?\d{8,12}$')
                              //       .hasMatch(value)) {
                              //     return 'رقمك غالط';
                              //   }
                              //   return null;
                              // },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding),
                              child: TextFormField(
                                controller: _passwordController,
                                textInputAction: TextInputAction.done,
                                obscureText: _passwordObscureText,
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _passwordObscureText =
                                            !_passwordObscureText;
                                      });
                                    },
                                    child: Icon(
                                      color: const Color(0xFF6F35A5),
                                      _passwordObscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                  hintText: "Your password",
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(defaultPadding),
                                    child: Icon(Icons.lock),
                                  ),
                                ),
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'ماتخليهاش فارغة';
                                //   } else if (value.length < 8) {
                                //     return 'كلمة السر قصيرة';
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            const SizedBox(height: defaultPadding),
                            Hero(
                              tag: "to_job",
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    _authLogin();
                                  }
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "تسجيل الدخول".toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: defaultPadding),
                            AlreadyAccount(
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const JobsScreen();
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//---------------------
