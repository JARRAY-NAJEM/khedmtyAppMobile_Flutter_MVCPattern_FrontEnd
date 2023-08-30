import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:khedmty_app/Controllers/JobController.dart';
import 'package:khedmty_app/Views/Components/Background.dart';
import 'package:khedmty_app/Views/Constants.dart';
import 'package:khedmty_app/Views/Components/Responsive.dart';
import 'package:khedmty_app/Views/Screens/Worker/WorkerScreen.dart';
import 'package:khedmty_app/Views/Screens/Profile/ProfileScreen.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final JobController _jobController =
      JobController(); // Create an instance of JobController

  // Create an instance of JobController
  Future<void> clearSharedPreferencesWork() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('work');
    setState(() {
      _work = prefs.getString('work') ?? '';
    });
    // print(_numberValue);
    // print(_passwordValue);
    // print("_loadSavedValue");
    // print("_work: $_work");
  }

  @override
  void initState() {
    super.initState();

    _jobController.fetchJobs(); // Fetch jobs when the widget initializes
    clearSharedPreferencesWork();
  }

  String _work = '';
  void _refreshJobs() {
    setState(() {
      _jobController.fetchJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Responsive(
          mobile: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: const Color(0xFF6F35A5).withOpacity(0.2),
                        ),
                        child: IconButton(
                          icon: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Icon(Icons.refresh),
                          ),
                          onPressed: () {
                            _refreshJobs();
                            clearSharedPreferencesWork();

                            print("refresh");
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.transparent,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.transparent,
                          ),
                          width: MediaQuery.of(context).size.width * 0.55 - 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.search,
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                hintText: "Search for a job",
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {
                                      // Perform search action here using _jobController.text
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: const Color(0xFF6F35A5).withOpacity(0.2),
                        ),
                        child: IconButton(
                          icon: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Icon(Icons.person),
                          ),
                          onPressed: () {
                            // _refreshJobs();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ),
                            );
                            print("refresh");
                          },
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: _jobController.fetchJobs(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          final jobs = _jobController.jobs;
                          return ResponsiveGridList(
                            horizontalGridMargin: 0,
                            verticalGridMargin: 0,
                            minItemWidth: 150,
                            children: List.generate(
                              jobs.length,
                              (index) => InkWell(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const WorkerScreen(),
                                    ),
                                  );

                                  print(jobs[index].job);
                                  print(jobs[index].image);
                                  print('${jobs[index].id}');

                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                      'work', jobs[index].job);

                                  setState(() {
                                    _work = prefs.getString('work') ?? '';
                                  });
                                  // print(_numberValue);
                                  // print(_passwordValue);
                                  // print("_loadSavedValue");
                                  print("_work: $_work");
                                },
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          jobs[index].job,
                                          style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      // Text(' ${jobs[index].id}'),
                                      // SizedBox(height: 10),
                                      // SizedBox(height: 10),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: CachedNetworkImage(
                                          imageUrl: jobs[index].image,
                                          width: 75,
                                          height: 75,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      // Image(
                                      //   image: NetworkImage(
                                      //     '${jobs[index].image}',

                                      //   ),
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {
                                              // Handle edit button press
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              // Handle delete button press
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          desktop: const Column(
            children: [Text("data")],
          )),
    );
  }
}

//---------------------------------------------

// class FixedTextField extends StatefulWidget {
//   const FixedTextField({super.key});

//   @override
//   State<FixedTextField> createState() => _FixedTextFieldState();
// }

// class _FixedTextFieldState extends State<FixedTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }
//----------------------------------------------------------

// class ResponsiveGrid extends StatefulWidget {
//   const ResponsiveGrid({super.key});

//   @override
//   State<ResponsiveGrid> createState() => _ResponsiveGridState();
// }

// class _ResponsiveGridState extends State<ResponsiveGrid> {


//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }
