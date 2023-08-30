import 'package:flutter/material.dart';

import 'package:khedmty_app/Views/Components/Background.dart';
import 'package:khedmty_app/Views/Constants.dart';
import 'package:khedmty_app/Views/Components/Responsive.dart';

class Experience extends StatefulWidget {
  const Experience({Key? key}) : super(key: key);

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Responsive(
          mobile: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.transparent,
                      ),
                      child: const FixedTextField()),
                  const Expanded(child: MyGridView()),
                ],
              ),
            ),
          ),
          desktop: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Column(
                children: [
                  // Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(50.0),
                  //       color: Colors.transparent,
                  //     ),
                  //     child: FixedTextField()),
                  // Expanded(child: MyGridView()
                  // ),
                ],
              ),
            ),
          ),
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
                // jobController.fetchJob();
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

class MyGridView extends StatelessWidget {
  const MyGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: defaultPadding * 0.1),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, // Maximum width for each item

          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 0.8, // Adjust as needed
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: defaultPadding * 1.5,
                    right: defaultPadding * 1.5,
                    left: defaultPadding * 1.5,
                  ),
                  child: Text(
                    'Item $index',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
