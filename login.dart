import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:app/registration.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required String title});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter an Email address";
    }
    if (!EmailValidator.validate(value)) {
      return "Please Enter valide Email address ";
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

  void submitForm() {
    if (formKey.currentState!.validate()) {
      print('The Form is validated');
    }
  }

  Future<void> postDataToServer() async {
    final apiUrl =
        Uri.parse('https://indone.api.mindvisiontechnologies.com/user/login');
    final data = {
      'email': email.text,
      'password': password.text,
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
    return GetMaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                height: 400,
                width: 600,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                ), // color: Colors.blue,
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      'Welcome Back Please Enter Your Details',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              key: formKey,
                              child: TextFormField(
                                validator: validateEmail,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white,
                                        style: BorderStyle.solid,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter),
                                  ),
                                  suffixIcon: Icon(Icons.email),
                                  suffixIconColor: Colors.white,
                                  labelText: "Email",
                                  labelStyle: TextStyle(color: Colors.white),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white,
                                        style: BorderStyle.solid,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: SizedBox(
                                child: TextFormField(
                                  validator: validatePassword,
                                  obscureText: true,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter),
                                    ),
                                    suffixIcon: Icon(Icons.visibility_off),
                                    suffixIconColor: Colors.white,
                                    labelText: "Password",
                                    labelStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter),
                                    ),
                                    hintText: 'Password',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text('Forget Pasword?')),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              submitForm();
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                side: BorderSide(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Divider(
                                indent: 20,
                                endIndent: 20,
                              ),
                              Container(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "Or",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(
                                  RegistrationPage(title: 'registrationpage'));
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                side: BorderSide(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        )
                      ],
                    ),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
