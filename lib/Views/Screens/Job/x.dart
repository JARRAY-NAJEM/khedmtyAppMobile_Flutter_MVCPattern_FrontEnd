import 'package:flutter/material.dart';
import 'package:khedmty_app/Controllers/JobController.dart';
import 'package:khedmty_app/Views/Constants.dart';
import 'package:khedmty_app/Views/Components/Responsive.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../../Components/Background.dart';

class Xyz extends StatefulWidget {
  const Xyz({super.key});

  // OnboardScreen({}) ;

  @override
  State<Xyz> createState() => _XyzState();
}

class _XyzState extends State<Xyz> {
  final JobController _jobController =
      JobController(); // Create an instance of JobController

  @override
  void initState() {
    super.initState();
    _jobController.fetchJobs(); // Fetch jobs when the widget initializes
  }

  void _refreshJobs() {
    setState(() {
      _jobController.fetchJobs(); // Fetch jobs again when refreshing
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
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
                            child: Icon(Icons.add),
                          ),
                          onPressed: () {
                            _refreshJobs();
                            print("refresh");
                          },
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.transparent,
                          ),
                          child: const FixedTextField()),
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
                                onTap: () {
                                  print(jobs[index].job);
                                  print(jobs[index].image);
                                  print('${jobs[index].id}');
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
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.network(
                                          jobs[index].image,
                                          width: 75,
                                          height: 75,
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
                  ),
                ],
              ),
            ),
          ),
          desktop: const Column(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 0.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                // Left button action
              },
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 0.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                _refreshJobs();
                print("refresh");
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
          ),
        ],
      ),
    );
  }
}

class FixedTextField extends StatelessWidget {
  const FixedTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.transparent,
      ),
      width: MediaQuery.of(context).size.width * 0.55 - 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
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
    );
  }
}
