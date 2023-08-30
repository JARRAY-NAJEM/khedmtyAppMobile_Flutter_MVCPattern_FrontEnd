import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khedmty_app/Views/Components/alreadyAccount.dart';
import 'package:khedmty_app/Views/Constants.dart';
import 'package:khedmty_app/Views/Components/Responsive.dart';
import 'package:khedmty_app/Views/Screens/SignUp/SignScreen.dart';
import 'package:khedmty_app/Views/Screens/SignUp/Widgets/or_divider.dart';
import 'package:khedmty_app/Views/Screens/SignUp/Widgets/social_icon.dart';

import '../../components/background.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({Key? key}) : super(key: key);

  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileJobScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "LOGIN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
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
                                    textInputAction: TextInputAction.done,
                                    cursorColor: kPrimaryColor,
                                    decoration: const InputDecoration(
                                      hintText: "Your password",
                                      prefixIcon: Padding(
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
                                Hero(
                                  tag: "login_btn",
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           JobsPage()),
                                      // );
                                    },
                                    child: Text(
                                      "تسجيل الدخول".toUpperCase(),
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
//----------------------------------------------------------------

class MobileJobScreen extends StatefulWidget {
  const MobileJobScreen({Key? key}) : super(key: key);

  @override
  _MobileJobScreenState createState() => _MobileJobScreenState();
}

class _MobileJobScreenState extends State<MobileJobScreen> {
  final List<String> items = List.generate(7, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            Row(
              children: <Widget>[
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.search,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Search for a job",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // Perform search action here using _jobController.text
                        },
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                    ),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  items[index],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: Image.network(
                              //     "https://cdn-icons-png.flaticon.com/256/1293/1293860.png",
                              //     width: 100,
                              //     height: 100,
                              //   ),
                              // ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.favorite),
                                    onPressed: () {
                                      // Handle favorite button press
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.share),
                                    onPressed: () {
                                      // Handle share button press
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
              ],
            )
          ],
        ),
      ],
    );
  }
}
