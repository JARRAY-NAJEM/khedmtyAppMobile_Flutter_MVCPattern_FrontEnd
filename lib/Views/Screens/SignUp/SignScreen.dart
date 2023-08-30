import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khedmty_app/Controllers/SignController.dart';
import 'package:khedmty_app/Models/SignModel.dart';
import 'package:khedmty_app/Views/Components/alreadyAccount.dart';
import 'package:khedmty_app/Views/Constants.dart';
import 'package:khedmty_app/Views/Components/Responsive.dart';
import 'package:khedmty_app/Views/Screens/Login/LoginScreen.dart';
import 'package:khedmty_app/Views/Screens/SignUp/Widgets/or_divider.dart';
import 'package:khedmty_app/Views/Screens/SignUp/Widgets/social_icon.dart';

import '../../components/background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController workController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool _passwordObscureText = true;
  final String _errorMessage = '';

//--------------------------
  final SignController _signController = SignController();

  void _authSignup() async {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String password = passwordController.text;
    String number = numberController.text;
    String work = workController.text;
    String address = _selectedState;
    String description = descriptionController.text;

    SignModel signModel = SignModel(
      firstName: firstName,
      lastName: lastName,
      password: password,
      number: number,
      work: work,
      address: address,
      description: description,
    );

    String? errorMessage = await _signController.signup(signModel);

    if (errorMessage == null) {
      print("success");
      _showSuccessDialog();
    } else {
      print("error");
      _showErrorDialog(errorMessage);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Signup Successful'),
          content: const Text('You have successfully signed up!'),
          actions: [
            _buildOkButton(),
          ],
        );
      },
    ).then(
      (_) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ),
      ),
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Signup Failed'),
          content: Text(_errorMessage),
          actions: [
            _buildOkButton(),
          ],
        );
      },
    );
  }

  Widget _buildOkButton() {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('OK'),
    );
  }

//-------------------

  String _selectedState = '';

  final List<String> _tunisianStates = [
    'Tunis',
    'Ariana',
    'Ben Arous',
    'Manouba',
    'Nabeul',
    'Zaghouan',
    'Bizerte',
    'Béja',
    'Jendouba',
    'Kef',
    'Siliana',
    'Kairouan',
    'Kasserine',
    'Sidi Bouzid',
    'Sousse',
    'Monastir',
    'Mahdia',
    'Sfax',
    'Gabès',
    'Medenine',
    'Tataouine',
    'Tozeur',
    'Kebili'
  ];

  void _showStates(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a state',
              style: TextStyle(color: Color(0xFF6F35A5))),
          content: SingleChildScrollView(
            child: Column(
              children: _tunisianStates.map((state) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedState = state;
                      print(_selectedState);
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    state,
                    style:
                        const TextStyle(fontSize: 20, color: Color(0xFF6F35A5)),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',
                  style: TextStyle(color: Color(0xFF6F35A5))),
            ),
          ],
        );
      },
    );
  }

//-----------------

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileSignupScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Sign Up".toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      children: [
                        const Spacer(),
                        Expanded(
                          flex: 8,
                          child: SvgPicture.asset("assets/icons/signup.svg"),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: firstNameController,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'اعطيني اسمك';
                                } else if (value.length < 3) {
                                  return 'ثبت في اسمك';
                                }
                                return null;
                              },
                              cursorColor: kPrimaryColor,
                              // onSaved: () {},
                              decoration: const InputDecoration(
                                // labelText: 'اسمك',
                                hintText: ' اسمك',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.person_4),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding),
                              child: TextFormField(
                                controller: lastNameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'اعطيني لقبك';
                                  } else if (value.length < 3) {
                                    return 'ثبت في لقبك';
                                  }
                                  return null;
                                },
                                // obscureText: true,
                                cursorColor: kPrimaryColor,
                                decoration: const InputDecoration(
                                  hintText: ' لقبك',
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(defaultPadding),
                                    child: Icon(Icons.person_4),
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'ماتخليهاش فارغة';
                                } else if (value.length < 8) {
                                  return 'كلمة السر قصيرة';
                                }
                                return null;
                              },
                              obscureText: _passwordObscureText,
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                hintText: ' كلمة السر',
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.lock),
                                ),
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
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: defaultPadding),
                              child: TextFormField(
                                controller: confPasswordController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'ماتخليهاش فارغة';
                                  } else if (value.length < 8) {
                                    return 'كلمة السر قصيرة';
                                  }
                                  return null;
                                },
                                obscureText: _passwordObscureText,
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  hintText: ' تاكيد كلمة السر',
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(defaultPadding),
                                    child: Icon(Icons.lock),
                                  ),
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
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding),
                              child: TextFormField(
                                controller: numberController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'ماتخليهاش فارغة';
                                  } else if (value.length < 8 ||
                                      value.length > 8) {
                                    return 'رقمك يلزمو من 8 ارقام';
                                  } else if (!['9', '5', '4', '2']
                                      .contains(value[0])) {
                                    return 'ثبت في رقمك باش يبدى';
                                  }
                                  return null;
                                },
                                // obscureText: true,
                                cursorColor: kPrimaryColor,
                                decoration: const InputDecoration(
                                  hintText: ' رقمك',
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(defaultPadding),
                                    child: Icon(Icons.phone),
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: workController,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'شنوا تخدم';
                                } else if (value.length < 3) {
                                  return 'ثبت في خدمتك';
                                }
                                return null;
                              },
                              // obscureText: true,
                              cursorColor: kPrimaryColor,
                              decoration: const InputDecoration(
                                hintText: 'شنوا تخدم',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.work),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding),
                              child: TextFormField(
                                readOnly: true,
                                controller:
                                    TextEditingController(text: _selectedState),
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' اختار ولايتك';
                                  }
                                  return null;
                                },
                                // obscureText: true,
                                cursorColor: kPrimaryColor,
                                decoration: const InputDecoration(
                                  hintText: 'في اي ولاية انت توا',
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(defaultPadding),
                                    child: Icon(Icons.map),
                                  ),
                                ),
                                onTap: () {
                                  _showStates(context);
                                },
                              ),
                            ),
                            TextFormField(
                              controller: descriptionController,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.done,
                              // obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'احكي شويا على خدمتك';
                                }
                                return null;
                              },
                              cursorColor: kPrimaryColor,
                              decoration: const InputDecoration(
                                hintText: 'احكي على خدمتك',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.text_decrease),
                                ),
                              ),
                            ),
                            const SizedBox(height: defaultPadding / 1),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print(_selectedState);
                                  _authSignup();

                                  // Print the values to the console
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  "انشاء حساب".toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(height: defaultPadding),
                            AlreadyAccount(
                              login: false,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const LoginScreen();
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Column(
                      children: [
                        const OrDivider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SocalIcon(
                              iconSrc: "assets/icons/facebook.svg",
                              press: () {},
                            ),
                            SocalIcon(
                              iconSrc: "assets/icons/twitter.svg",
                              press: () {},
                            ),
                            SocalIcon(
                              iconSrc: "assets/icons/google-plus.svg",
                              press: () {},
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//----------------------------------------------------------

class MobileSignupScreen extends StatefulWidget {
  const MobileSignupScreen({Key? key}) : super(key: key);

  @override
  _MobileSignupScreenState createState() => _MobileSignupScreenState();
}

class _MobileSignupScreenState extends State<MobileSignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController workController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool _passwordObscureText = true;
  final String _errorMessage = '';

//--------------------------
  final SignController _signController = SignController();

  void _authSignup() async {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String password = passwordController.text;
    String number = numberController.text;
    String work = workController.text;
    String address = _selectedState;
    String description = descriptionController.text;

    SignModel signModel = SignModel(
      firstName: firstName,
      lastName: lastName,
      password: password,
      number: number,
      work: work,
      address: address,
      description: description,
    );

    String? errorMessage = await _signController.signup(signModel);

    if (errorMessage == null) {
      print("success");
      _showSuccessDialog();
    } else {
      print("error");
      _showErrorDialog(errorMessage);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Signup Successful'),
          content: const Text('You have successfully signed up!'),
          actions: [
            _buildOkButton(),
          ],
        );
      },
    ).then(
      (_) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ),
      ),
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Signup Failed'),
          content: Text(_errorMessage),
          actions: [
            _buildOkButton(),
          ],
        );
      },
    );
  }

  Widget _buildOkButton() {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('OK'),
    );
  }

//-------------------

  String _selectedState = '';

  final List<String> _tunisianStates = [
    'Tunis',
    'Ariana',
    'Ben Arous',
    'Manouba',
    'Nabeul',
    'Zaghouan',
    'Bizerte',
    'Béja',
    'Jendouba',
    'Kef',
    'Siliana',
    'Kairouan',
    'Kasserine',
    'Sidi Bouzid',
    'Sousse',
    'Monastir',
    'Mahdia',
    'Sfax',
    'Gabès',
    'Medenine',
    'Tataouine',
    'Tozeur',
    'Kebili'
  ];

  void _showStates(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a state',
              style: TextStyle(color: Color(0xFF6F35A5))),
          content: SingleChildScrollView(
            child: Column(
              children: _tunisianStates.map((state) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedState = state;
                      print(_selectedState);
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    state,
                    style:
                        const TextStyle(fontSize: 20, color: Color(0xFF6F35A5)),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',
                  style: TextStyle(color: Color(0xFF6F35A5))),
            ),
          ],
        );
      },
    );
  }

//-----------------

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            // Text(
            //   "Sign Up".toUpperCase(),
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: SvgPicture.asset(
                    "assets/icons/signup.svg",
                    width: 200,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: defaultPadding),
          ],
        ),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'اعطيني اسمك';
                        } else if (value.length < 3) {
                          return 'ثبت في اسمك';
                        }
                        return null;
                      },
                      cursorColor: kPrimaryColor,
                      // onSaved: () {},
                      decoration: const InputDecoration(
                        // labelText: 'اسمك',
                        hintText: ' اسمك',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.person_4),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextFormField(
                        controller: lastNameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'اعطيني لقبك';
                          } else if (value.length < 3) {
                            return 'ثبت في لقبك';
                          }
                          return null;
                        },
                        // obscureText: true,
                        cursorColor: kPrimaryColor,
                        decoration: const InputDecoration(
                          hintText: ' لقبك',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.person_4),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ماتخليهاش فارغة';
                        } else if (value.length < 8) {
                          return 'كلمة السر قصيرة';
                        }
                        return null;
                      },
                      obscureText: _passwordObscureText,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hintText: ' كلمة السر',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.lock),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _passwordObscureText = !_passwordObscureText;
                            });
                          },
                          child: Icon(
                            color: const Color(0xFF6F35A5),
                            _passwordObscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: defaultPadding),
                      child: TextFormField(
                        controller: confPasswordController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'ماتخليهاش فارغة';
                          } else if (value.length < 8) {
                            return 'كلمة السر قصيرة';
                          }
                          return null;
                        },
                        obscureText: _passwordObscureText,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: ' تاكيد كلمة السر',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.lock),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordObscureText = !_passwordObscureText;
                              });
                            },
                            child: Icon(
                              color: const Color(0xFF6F35A5),
                              _passwordObscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextFormField(
                        controller: numberController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'ماتخليهاش فارغة';
                          } else if (value.length < 8 || value.length > 8) {
                            return 'رقمك يلزمو من 8 ارقام';
                          } else if (!['9', '5', '4', '2'].contains(value[0])) {
                            return 'ثبت في رقمك باش يبدى';
                          }
                          return null;
                        },
                        // obscureText: true,
                        cursorColor: kPrimaryColor,
                        decoration: const InputDecoration(
                          hintText: ' رقمك',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.phone),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: workController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'شنوا تخدم';
                        } else if (value.length < 3) {
                          return 'ثبت في خدمتك';
                        }
                        return null;
                      },
                      // obscureText: true,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: 'شنوا تخدم',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.work),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextFormField(
                        readOnly: true,
                        controller: TextEditingController(text: _selectedState),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' اختار ولايتك';
                          }
                          return null;
                        },
                        // obscureText: true,
                        cursorColor: kPrimaryColor,
                        decoration: const InputDecoration(
                          hintText: 'في اي ولاية انت توا',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.map),
                          ),
                        ),
                        onTap: () {
                          _showStates(context);
                        },
                      ),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      // obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'احكي شويا على خدمتك';
                        }
                        return null;
                      },
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: 'احكي على خدمتك',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.text_decrease),
                        ),
                      ),
                    ),
                    const SizedBox(height: defaultPadding / 1),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print(_selectedState);
                          _authSignup();

                          // Print the values to the console
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "انشاء حساب".toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    AlreadyAccount(
                      login: false,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        Column(
          children: [
            const OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            )
          ],
        )
      ],
    );
  }
}
