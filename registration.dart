import 'dart:convert';
import 'package:app/landingpage.dart';
import 'package:http/http.dart' as http;

//import 'package:email_validator/email_validator.dart';
import 'package:app/login.dart';
import 'package:flutter/material.dart';
// import 'package:app/controller.dart';
// import 'controller.dart';
import 'package:get/get.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({super.key, required String title});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController Name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController Mobilenumber = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter a Valid Email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "PLease Enter Password";
    }
    if (value.length < 8) {
      return "Password must be 8 charcters Long";
    }
    return null;
  }

  String? validatepassword(String? value) {
    if (value == null || value.isEmpty) {
      return "PLease Enter Password";
    }
    if (value.length < 8) {
      return "Password must be 8 charcters Long";
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Password";
    }
    return null;
  }

  String? validateMobilenumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Password";
    }
    return null;
  }

  Future<void> postDataToServer() async {
    final apiUrl = Uri.parse(
        'http://indone.api.mindvisiontechnologies.com/user/registration');
    final data = {
      'email': email.text,
      'password': password.text,
      'MobileNumber': Mobilenumber.text,
      'Name': Name.text,
    };
    final jsonData = json.encode(data);
    print(jsonData);
    final response = await http.post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonData,
    );
    if (response.statusCode == 200) {
      print('data sent successfully');
      print('Response:${response.body}');
    } else {
      print('Error sending data.status code: ${response.statusCode}');
      print('Response:${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Text(
                    'Register here',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Form(
                                key: _formkey,
                                child: TextFormField(
                                  validator: validateName,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    suffixIcon: Icon(Icons.man),
                                    suffixIconColor: Colors.white,
                                    labelText: "Name",
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            validator: validateEmail,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              suffixIcon: Icon(Icons.email),
                              suffixIconColor: Colors.white,
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            obscureText: true,
                            validator: validatepassword,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              suffixIcon: Icon(Icons.visibility_off),
                              suffixIconColor: Colors.white,
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            validator: validateMobilenumber,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              suffixIcon: Icon(Icons.android_outlined),
                              suffixIconColor: Colors.white,
                              labelText: "Mobile number",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(LandingPage());
                            },
                            child: Text('Singin'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              side: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.back(
                                  result: LoginPage(
                                title: 'loginpage',
                              ));
                            },
                            child: Text('Do You Already have an Account'))
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
