import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:khedmty_app/Controllers/WorkerController.dart';
import 'package:khedmty_app/Models/SignModel.dart';
import 'package:khedmty_app/Models/WorkerModel.dart';
import 'package:khedmty_app/Views/Constants.dart';
import 'package:khedmty_app/Views/Screens/Welcome/welcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isEditable = false;
  bool _isEditMode = false;

  String _numberValue = '';
  String _passwordValue = '';
  String _id = '';

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('number');
    prefs.remove('password');
    prefs.remove('id');
    print("success");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
  }

  final WorkerController _WorkerController = WorkerController();
  // final WorkerModel _updatedWorker = WorkerModel();

  String firstName = '';
  String lastName = '';
  String password = '';
  String number = '';
  String work = '';
  String address = '';
  String description = '';
  final String apiUrl3 = 'http://10.0.2.2:3000/worker/update';

  // Future<void> updateUser(
  //   String firstName,
  //   String lastName,
  //   String password,
  //   String number,
  //   String work,
  //   String address,
  //   String description,
  // ) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final id = prefs.getString('id') ?? '';
  //   final updateUrl = '$apiUrl3/$id';
  //   try {
  //     final response = await http.put(
  //       Uri.parse(updateUrl),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         'firstName': firstName,
  //         'firstName': firstName,
  //         'lastName': lastName,
  //         'password': password,
  //         'number': number,
  //         'work': work,
  //         'address': address,
  //         'description': description,
  //       }),
  //     );
  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       final data = json.decode(response.body);
  //       print(data);

  //     } else {
  //       print(response.body);
  //     }
  //   } catch (e) {
  //     print(e);

  //   }
  // }

  Future<void> _handleUpdateUser(
    String firstName,
    String lastName,
    String password,
    String number,
    String work,
    String address,
    String description,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';

    try {
      await _WorkerController.updateProfileData(
        id: id,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        password: _passwordController.text,
        number: _numberController.text,
        work: _workController.text,
        address: _addressController.text,
        description: _descriptionController.text,
      );
      print('User updated successfully');
    } catch (e) {
      print('Failed to update user: $e');
    }
  }

  Future<void> _loadSavedValue() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';
    print('isd;$id');
  }

  void _deleteWorker() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';

    try {
      await WorkerController().deleteWorkerData(id);
      print("succes");
      // Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchWorkerById() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';
    try {
      final WorkerData = await _WorkerController.fetchWorkerData(id);
      setState(() {
        firstName = WorkerData.firstName;
        lastName = WorkerData.lastName;
        password = WorkerData.password;
        number = WorkerData.number;
        work = WorkerData.work;
        address = WorkerData.address;
        description = WorkerData.description;
        _firstNameController.text = WorkerData.firstName;
        _lastNameController.text = WorkerData.lastName;
        // _passwordController.text = WorkerData.password;
        _numberController.text = WorkerData.number;
        _workController.text = WorkerData.work;
        _addressController.text = WorkerData.address;
        _descriptionController.text = WorkerData.description;
      });
      // print(address);
      // print(firstName);
      // print(lastName);
      // print(number);
      // print(work);
      // print(address);
      // print(description);
    } catch (e) {
      print("Error fetching Worker data: $e");
      // Handle the error
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch Worker data when the screen is initialized
    Future.wait([fetchWorkerById(), _loadSavedValue()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة الملف الشخصي'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: Padding(
        //       padding: const EdgeInsets.all(10),
        //       child: Icon(Icons.exit_to_app),
        //     ), // Replace with the desired icon
        //     onPressed: () {
        //       clearSharedPreferences();
        //     },
        //   ),
        // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 50, bottom: 25),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://i.ibb.co/MnX9b6V/Capture-d-cran-2023-05-22-044311.png",
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '$firstName $lastName',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '$work',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '$description',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isEditMode
                          ? null
                          : () {
                              setState(() {
                                // _deleteWorker();
                                _isEditMode =
                                    !_isEditMode; // Toggle the edit mode
                              });
                            },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          ' تعديل المعلومات ',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      enabled: _isEditMode,
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        hintText: 'الاسم الأول',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك أدخل الاسم الأول';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      enabled: _isEditMode,
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        hintText: 'اسم العائلة',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك أدخل اسم العائلة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      enabled: _isEditMode,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: 'كلمة المرور',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك أدخل كلمة المرور';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      enabled: _isEditMode,
                      controller: _confPasswordController,
                      decoration: const InputDecoration(
                        hintText: 'تأكيد كلمة المرور',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك قم بتأكيد كلمة المرور';
                        }
                        if (value != _passwordController.text) {
                          return 'كلمات المرور غير متطابقة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      enabled: _isEditMode,
                      controller: _numberController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "رقم هاتفك",
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك أدخل رقم هاتفك';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      enabled: _isEditMode,
                      controller: _workController,
                      decoration: const InputDecoration(
                        hintText: 'العمل',
                        prefixIcon: Icon(Icons.work),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك أدخل معلومات العمل';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      enabled: _isEditMode,
                      controller: _addressController,
                      decoration: const InputDecoration(
                        hintText: 'العنوان',
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك أدخل العنوان';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      enabled: _isEditMode,
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'الوصف',
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _deleteWorker();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                ' حذف الحساب',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.red,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: !_isEditMode
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    await _handleUpdateUser(
                                        _firstNameController.text,
                                        _lastNameController.text,
                                        _passwordController.text,
                                        _numberController.text,
                                        _workController.text,
                                        _addressController.text,
                                        _descriptionController.text);
                                    fetchWorkerById();
                                    setState(() {
                                      _isEditMode = !_isEditMode;
                                    });
                                  }
                                },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'حفظ المعلومات',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.green,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: defaultPadding),
                      child: ElevatedButton(
                        onPressed: () {
                          clearSharedPreferences();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'تسجيل الخروج',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
