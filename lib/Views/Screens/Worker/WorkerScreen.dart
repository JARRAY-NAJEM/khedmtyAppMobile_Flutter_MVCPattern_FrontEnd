import 'package:flutter/material.dart';
import 'package:khedmty_app/Controllers/WorkerController.dart';
import 'package:khedmty_app/Models/WorkerModel.dart';
import 'package:khedmty_app/Views/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerScreen extends StatefulWidget {
  const WorkerScreen({super.key});

  @override
  State<WorkerScreen> createState() => _WorkerScreenState();
}

class _WorkerScreenState extends State<WorkerScreen> {
  int _currentIndex = -1;

  String work = "";
  void _loadSavedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      work = prefs.getString('work') ?? '';
    });
    // print(_numberValue);
    // print(_passwordValue);
    print("work in WorkerPage: $work");
  }

  final WorkerController _workerController = WorkerController();

  void _toggleTap(int index) {
    setState(() {
      if (_currentIndex == index) {
        _currentIndex = -1; // close the current inkwell
      } else {
        _currentIndex = index; // open the new inkwell
      }
    });
  }

  void _toggleExpand(bool value) {
    // no changes needed here
  }
  String _firstName = '';
  String _lastName = '';
  String _password = '';
  String _number = '';
  String _work = '';
  String _address = '';
  String _description = '';
  List<WorkerModel> _workers = []; // Initialize with an empty list

  Future<void> fetchWorkersByWork() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    work = _prefs.getString('work') ?? '';

    try {
      final workers = await _workerController.fetchWorkersByWork(work);
      setState(() {
        _workers = workers;
      });
      print(_workers.length);
      if (workers.isNotEmpty) {
        print("Fetched ${workers.length} workers");
      } else {
        print("No workers found for the specified work.");
      }
    } catch (e) {
      print("Error fetching Worker data: $e");
      // handle other exceptions
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSavedValue();
    fetchWorkersByWork();
    // _workerController.fetchWorkersByWork(work)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.transparent,
            ),
            width: MediaQuery.of(context).size.width * 0.78,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.search,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Search for a job",
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(0),
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
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: _workers.length,
                itemBuilder: (context, index) {
                  var worker = _workers[index];
                  return ListTile(
                    title:

                        //  Text(worker
                        //     .work), // Replace 'name' with the actual property in your worker model
                        // subtitle: Text(worker
                        //     .description), // Replace 'description' with the actual property in your worker model
                        // Add more Text widgets or other widgets to display additional worker data

                        InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => _toggleTap(index),
                      onHighlightChanged: _toggleExpand,
                      child: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 250),
                        crossFadeState: _currentIndex == index
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        firstChild: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF6F35A5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: const Color(0xFF6F35A5),
                            //     blurRadius: 20,
                            //     offset: const Offset(0, 10),
                            //   ),
                            // ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 40,
                                      // backgroundImage: AssetImage(
                                      //     'assets/profile_image.jpg'), // Replace with your image path
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${worker.firstName} ${worker.lastName}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        worker.work,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          worker.address,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                _currentIndex == index
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 27,
                              ),
                            ],
                          ),
                        ),
                        secondChild: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF6F35A5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6F35A5),
                                // blurRadius: 20,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 40,
                                          // backgroundImage: AssetImage(
                                          //     'assets/profile_image.jpg'), // Replace with your image path
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${worker.firstName} ${worker.lastName}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            worker.work,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              worker.address,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    _currentIndex == index
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 27,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                worker.description,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final phoneNumber = 'tel:${worker.number}';
                                    try {
                                      await launch(phoneNumber);
                                    } catch (e) {
                                      print('Error launching phone call: $e');
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                        SizedBox(width: 18),
                                        Text(
                                          ' اتصل على ${worker.number}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor:
                                        Color.fromARGB(255, 206, 130, 241)
                                            .withOpacity(0.5),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
