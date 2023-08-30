import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:khedmty_app/Views/Constants.dart';
import 'package:khedmty_app/Views/Screens/Job/JobsScreen.dart';
import 'package:khedmty_app/Views/Screens/Login/LoginScreen.dart';
import 'package:khedmty_app/Views/Screens/Splash/SplashScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0, backgroundColor: kPrimaryColor,
              // shape: const StadiumBorder(),
              // maximumSize: const Size(double.infinity, 56),
              // minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: SplashScreen(),
    );
  }
}

// class ScreenWidget extends StatelessWidget {
//   final String title;

//   const ScreenWidget(this.title, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Text('$title Screen Content'),
//       ),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   static const List<String> listOfStrings = [
//     'Home',
//     'Favorite',
//     'Settings',
//     'Account',
//   ];

//   final List<IconData> listOfIcons = [
//     Icons.home_rounded,
//     Icons.favorite_rounded,
//     Icons.settings_rounded,
//     Icons.person_rounded,
//   ];
//   int currentIndex = 0;
//   static final List<Widget> _widgetOptions = <Widget>[
//     const Xyz(),
//     const LoginScreen(),
//     const Xyz(),
//     const Xyz(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }

//   late final PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   Widget buildNavBarItem(int index, double displayWidth) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           currentIndex = index;
//           HapticFeedback.lightImpact();
//         });
//       },
//       splashColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//       child: Stack(
//         children: [
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.fastLinearToSlowEaseIn,
//             width:
//                 index == currentIndex ? displayWidth * .32 : displayWidth * .18,
//             alignment: Alignment.center,
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.fastLinearToSlowEaseIn,
//               height: index == currentIndex ? displayWidth * .12 : 0,
//               width: index == currentIndex ? displayWidth * .32 : 0,
//               decoration: BoxDecoration(
//                 color: index == currentIndex
//                     ? const Color(0xFF6F35A5).withOpacity(.2)
//                     : Colors.transparent,
//                 borderRadius: BorderRadius.circular(50),
//               ),
//             ),
//           ),
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.fastLinearToSlowEaseIn,
//             width:
//                 index == currentIndex ? displayWidth * .31 : displayWidth * .18,
//             alignment: Alignment.center,
//             child: Stack(
//               children: [
//                 Row(
//                   children: [
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.fastLinearToSlowEaseIn,
//                       width: index == currentIndex ? displayWidth * .13 : 0,
//                     ),
//                     AnimatedOpacity(
//                       opacity: index == currentIndex ? 1 : 0,
//                       duration: Duration.zero,
//                       child: Text(
//                         index == currentIndex ? listOfStrings[index] : '',
//                         style: const TextStyle(
//                           color: Color(0xFF6F35A5),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.fastLinearToSlowEaseIn,
//                       width: index == currentIndex ? displayWidth * .03 : 20,
//                     ),
//                     Icon(
//                       listOfIcons[index],
//                       size: displayWidth * .08,
//                       color: index == currentIndex
//                           ? const Color(0xFF6F35A5)
//                           : Colors.black26,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double displayWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       bottomNavigationBar: Container(
//         // color: Colors.black,
//         margin: EdgeInsets.symmetric(
//             horizontal: displayWidth * .05, vertical: displayWidth * .01),
//         height: displayWidth * .15,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.1),
//               blurRadius: 30,
//               offset: const Offset(0, 10),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(50),
//         ),
//         child: ListView.builder(
//           itemCount: listOfStrings.length,
//           scrollDirection: Axis.horizontal,
//           padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
//           itemBuilder: (context, index) => buildNavBarItem(index, displayWidth),
//         ),
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(currentIndex),
//       ),
//     );
//   }
// }

// //-----------------------

// class SecondPage extends StatefulWidget {
//   @override
//   _SecondPageState createState() => _SecondPageState();
// }

// class _SecondPageState extends State<SecondPage>
//     with SingleTickerProviderStateMixin {
//   bool _a = false;
//   bool _b = false;
//   bool _c = false;
//   bool _d = false;
//   bool _e = false;

//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     startAnimation();
//     _controller = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     )..repeat();
//     _animation = Tween(begin: 0.0, end: 360.0).animate(_controller);
//   }

//   Future<void> startAnimation() async {
//     await Future.delayed(Duration(milliseconds: 250));
//     setState(() {
//       _e = true;
//     });
//     await Future.delayed(Duration(milliseconds: 300));
//     setState(() {
//       _a = true;
//     });
//     await Future.delayed(Duration(milliseconds: 300));
//     setState(() {
//       _b = true;
//     });
//     await Future.delayed(Duration(milliseconds: 600));
//     setState(() {
//       _c = true;
//     });
//     await Future.delayed(Duration(milliseconds: 700));
//     setState(() {
//       _d = true;
//     });
//     await Future.delayed(Duration(milliseconds: 800));
//     Navigator.of(context).push(
//       ThisIsFadeRoute(
//         route: OnboardScreen(),
//         page: OnboardScreen(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double _h = MediaQuery.of(context).size.height;
//     final double _w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // AnimatedBuilder(
//             //   animation: _animation,
//             //   builder: (context, child) {
//             //     return Transform.rotate(
//             //       angle: _animation.value,
//             //       child: Image.asset('path/to/image.png'),
//             //     );
//             //   },
//             // ),
//             AnimatedContainer(
//               duration: Duration(milliseconds: _d ? 300 : 600),
//               curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
//             ),
//             AnimatedContainer(
//               duration: Duration(seconds: _d ? 1 : (_c ? 2 : 0)),
//               curve: Curves.fastLinearToSlowEaseIn,
//               height: 500,
//               width: 400,
//               decoration: BoxDecoration(
//                 color: _b ? Colors.transparent : Colors.transparent,
//                 borderRadius:
//                     _d ? BorderRadius.only() : BorderRadius.circular(30),
//               ),
//               child: Center(
//                 child: _e
//                     ? Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Transform.scale(
//                             scale: 1.2,
//                             child: Image.asset(
//                               'assets/images/logo.png',
//                               height: 400,
//                               width: 400,
//                             ),
//                           ),
//                         ],
//                       )
//                     : SizedBox(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class ThisIsFadeRoute extends PageRouteBuilder {
//   final Widget page;
//   final Widget route;

//   ThisIsFadeRoute({required this.page, required this.route})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               FadeTransition(
//             opacity: animation,
//             child: route,
//           ),
//         );
// }

// //------------------------
// //------------------------
// //------------------------
// //------------------------
// //------------------------
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController _controller1 = TextEditingController();
//   TextEditingController _controller2 = TextEditingController();
//   String _savedValue1 = '';
//   String _savedValue2 = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedValue();
//   }

//   void _loadSavedValue() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _savedValue1 = prefs.getString('saved_value1') ?? '';
//       _savedValue2 = prefs.getString('saved_value2') ?? '';
//     });
//   }

//   void _saveValue() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('saved_value1', _controller1.text);
//     await prefs.setString('saved_value2', _controller2.text);
//     _loadSavedValue();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SharedPreferences Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _controller1,
//               decoration: InputDecoration(labelText: 'Enter a value'),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _controller2,
//               decoration: InputDecoration(labelText: 'Enter another value'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _saveValue,
//               child: Text('Save Value'),
//             ),
//             SizedBox(height: 16),
//             Text('Saved Value1: $_savedValue1'),
//             Text('Saved Value2: $_savedValue2'),
//             ElevatedButton(
//               onPressed: () {
//                 if (_savedValue1.isEmpty && _savedValue2.isEmpty) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Two()),
//                   );
//                 } else {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Tree()),
//                   );
//                 }
//               },
//               child: Text('Navigate'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Two extends StatefulWidget {
//   const Two({super.key});

//   @override
//   State<Two> createState() => _TwoState();
// }

// class _TwoState extends State<Two> {
//   String _savedValue1 = '';
//   String _savedValue2 = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedValue();
//   }

//   void _loadSavedValue() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _savedValue1 = prefs.getString('saved_value1') ?? '';
//       _savedValue2 = prefs.getString('saved_value2') ?? '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         color: Colors.lightBlue,
//         child: Text('login Page Saved Value1: $_savedValue1'
//             'Saved Value2: $_savedValue2'),
//       ),
//     );
//   }
// }

// class Tree extends StatefulWidget {
//   const Tree({super.key});

//   @override
//   State<Tree> createState() => _TreeState();
// }

// class _TreeState extends State<Tree> {
//   String _savedValue1 = '';
//   String _savedValue2 = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedValue();
//   }

//   void _loadSavedValue() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _savedValue1 = prefs.getString('saved_value1') ?? '';
//       _savedValue2 = prefs.getString('saved_value2') ?? '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         color: Colors.lightBlue,
//         child: Text('JpbPage Saved Value1 done: $_savedValue1'
//             'Saved Value2 done: $_savedValue2'),
//       ),
//     );
//   }
// }
// //-------------------------

// class UserWorkerScreen extends StatefulWidget {
//   final String userId = "4";

//   @override
//   _UserWorkerScreenState createState() => _UserWorkerScreenState();
// }

// class _UserWorkerScreenState extends State<UserWorkerScreen> {
//   late Future<WorkerModel?> _userDataFuture;
//   late WorkerModel _userData;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _userDataFuture = WorkerController.fetchUserDataById(widget.userId);
//   //   _userDataFuture.then((userData) {
//   //     if (userData != null) {
//   //       setState(() {
//   //         _userData = userData;
//   //       });
//   //     }
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<WorkerModel?>(
//       future: _userDataFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (!snapshot.hasData) {
//           return Text('No data available.');
//         } else {
//           final userData = snapshot.data!;
//           return Column(
//             children: [
//               Text('First Name: ${userData.firstName}'),
//               Text('Last Name: ${userData.lastName}'),
//               // Add other fields here
//             ],
//           );
//         }
//       },
//     );
//   }
// }
