import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:khedmty_app/Views/Constants.dart';
import 'package:khedmty_app/Views/Components/Responsive.dart';

import '../../components/background.dart';

class SignUpScreenT extends StatefulWidget {
  const SignUpScreenT({Key? key}) : super(key: key);

  @override
  _SignUpScreenTState createState() => _SignUpScreenTState();
}

class _SignUpScreenTState extends State<SignUpScreenT> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileSignUpScreenT(),
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
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("انشاء حساب".toUpperCase()),
                          ),
                        ],
                      ),
                    ),
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

class MobileSignUpScreenT extends StatefulWidget {
  const MobileSignUpScreenT({Key? key}) : super(key: key);

  @override
  _MobileSignUpScreenTState createState() => _MobileSignUpScreenTState();
}

class _MobileSignUpScreenTState extends State<MobileSignUpScreenT> {
  final List<String> ittems = List.generate(20, (index) => 'Item ${index + 1}');

  Widget _buildItemList() {
    return ListView.builder(
      itemCount: ittems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(ittems[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 450,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("انشاء حساب".toUpperCase()),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
