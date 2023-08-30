import 'package:flutter/material.dart';
import 'package:khedmty_app/Views/Constants.dart';

class AlreadyAccount extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyAccount({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "لا تملك حسابًا ? " : "هل لديك حساب بالفعل؟ ? ",
          style: const TextStyle(color: kPrimaryColor, fontSize: 20),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? "انشاء حسلب" : "تسجيل الدخول",
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
