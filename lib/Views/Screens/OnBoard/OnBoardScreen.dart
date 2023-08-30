import 'package:flutter/material.dart';
import 'package:khedmty_app/Views/Components/Background.dart';
import 'package:khedmty_app/Views/Constants.dart';
import 'package:khedmty_app/Views/Screens/Welcome/welcomeScreen.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int currentIndex = 0;
  void onNextPressed() {
    setState(() {
      if (currentIndex < allinonboardlist.length - 1) {
        currentIndex++;
      } else {
        // Handle navigation to the next screen after onboarding
        // For example, you can use Navigator to navigate to the home screen.
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  List<AllinOnboardModel> allinonboardlist = [
    AllinOnboardModel(
        "assets/images/slider_0.png",
        " خدمتي يخليك تتواصل مباشرة مع اصحاب الخدمات و تاخذ مواعيد معاهما ايضا يوفرلك مجموعة كبيرة متع عباد تخدم باش يلبّيلك حاجياتك",
        "تواصل معنا "),
    AllinOnboardModel(
        "assets/images/slider_5.png",
        "كان تلوج على شكون يخدملك و الا يعاونك  في ولايتك و الا في ولاية اخرى عليك بخدمتي",
        "حياتك اسهل معنا "),
    AllinOnboardModel(
        "assets/images/slider.png",
        " خدمتي يضمنلك آلاف المقدمين للخدمات فمجالات متعددة باش تقضي حاجياتك و يسهّل عليك  البحث على الخدمات لحاجياتك",
        "ابرز الخبراء"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemCount: allinonboardlist.length,
                  itemBuilder: (context, index) {
                    return PageBuilderWidget(
                        title: allinonboardlist[index].titlestr,
                        description: allinonboardlist[index].description,
                        imgurl: allinonboardlist[index].imgStr);
                  }),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.455,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    allinonboardlist.length,
                    (index) => buildDot(index: index),
                  ),
                ),
              ),
              currentIndex < allinonboardlist.length - 1
                  ? Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WelcomeScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: lightgreenshede1,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50.0),
                                      bottomRight: Radius.circular(50.0))),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                "Skip",
                                style: TextStyle(
                                    fontSize: 18, color: primaryColor),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: onNextPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: lightgreenshede1,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      bottomLeft: Radius.circular(50.0))),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 18, color: primaryColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.035,
                      left: MediaQuery.of(context).size.width * 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WelcomeScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: lightgreenshede1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "   مرحبا بك   ",
                                style: TextStyle(
                                    fontSize: 25, color: primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentIndex == index ? 20 : 6,
      decoration: BoxDecoration(
        color:
            currentIndex == index ? lightgreenshede1 : const Color(0xFF6F35A5),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class PageBuilderWidget extends StatelessWidget {
  String title;
  String description;
  String imgurl;
  PageBuilderWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.imgurl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Container(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  imgurl,
                  scale: 1,
                ),
              ),

              //Tite Text
              Text(title,
                  style: TextStyle(
                      color: primarygreen,
                      fontSize: 24,
                      fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 50,
              ),
              //discription
              Text(description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: primarygreen,
                      fontSize: 16,
                      fontWeight: FontWeight.w600))
            ],
          ),
        ),
      ],
    );
  }
}

class AllinOnboardModel {
  String imgStr;
  String description;
  String titlestr;
  AllinOnboardModel(this.imgStr, this.description, this.titlestr);
}
