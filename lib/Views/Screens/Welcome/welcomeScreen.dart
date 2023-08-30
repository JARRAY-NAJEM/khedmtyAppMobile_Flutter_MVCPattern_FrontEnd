import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khedmty_app/Views/Components/Background.dart';
import 'package:khedmty_app/Views/Constants.dart';
import 'package:khedmty_app/Views/Components/Responsive.dart';
import 'package:khedmty_app/Views/Screens/Job/JobScreen.dart';
import 'package:khedmty_app/Views/Screens/Job/JobsScreen.dart';
import 'package:khedmty_app/Views/Screens/Login/LoginScreen.dart';
import 'package:khedmty_app/Views/Screens/Worker/WorkerScreen.dart';
import 'package:khedmty_app/Views/Screens/SignUp/SignScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      // const Text(
                      //   "WELCOME TO EDU",
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      const SizedBox(height: defaultPadding * 2),
                      Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 8,
                            child: SvgPicture.asset(
                              "assets/icons/chat.svg",
                            ),
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
                        child: Column(
                          children: [
                            Hero(
                              tag: "login_btn",
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const LoginScreen();
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  "Login".toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const SignUpScreen();
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryLightColor,
                                  elevation: 0),
                              child: Text(
                                "Sign Up".toUpperCase(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            mobile: const MobileWelcomeScreen(),
          ),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatefulWidget {
  const MobileWelcomeScreen({super.key});

  @override
  _MobileWelcomeScreenState createState() => _MobileWelcomeScreenState();
}

class _MobileWelcomeScreenState extends State<MobileWelcomeScreen> {
  String _numberValue = '';
  String _passwordValue = '';
  String _id = '';

  // void _loadSavedValue() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _numberValue = prefs.getString('number') ?? '';
  //     _passwordValue = prefs.getString('password') ?? '';
  //   });
  // }

  void testLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final _numberValue = prefs.getString('number') ?? '';
    final _passwordValue = prefs.getString('password') ?? '';
    final _id = prefs.getString('id') ?? '';
    print("_loadSavedValue");
    print("ID: $_id");
    print("_numberValue: $_numberValue");
    print("_passwordValue: $_passwordValue");
    if (_numberValue.isNotEmpty && _passwordValue.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JobsScreen()),
      );
    } else {
      // setState(() {
      //   _numberValue = numberValue;
      //   _passwordValue = passwordValue;
      // });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // _loadSavedValue();
    //
    //

    //// Load previously saved data from SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            const SizedBox(height: defaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: SvgPicture.asset(
                    "assets/icons/chat.svg",
                  ),
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
              flex: 8,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Hero(
                      tag: "login_btn",
                      child: ElevatedButton(
                        onPressed: testLogin,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "تسجيل الدخول".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Hero(
                      tag: "sign_btn",
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignUpScreen();
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryLightColor, elevation: 0),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "انشاء حساب".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
