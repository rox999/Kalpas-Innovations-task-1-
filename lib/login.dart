import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:task1/registrationPage.dart';

import 'homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  _LoginData _Data = new _LoginData();

  String _url = "http://nodejs-register-login-app.herokuapp.com/login";

  Future<void> _loginRequest() async {
    print(
        "----------------------------- Login Page : login request method -----------------------------");
    final response = await http.post(Uri.parse(_url), headers: {}, body: {
      "email": _Data.email,
      "password": _Data.password,
    });
    Response resp = Response.fromJson(jsonDecode(response.body));
    if (resp.res == "Success!") {
      GetStorage().write('email', _Data.email);
      GetStorage().write('password', _Data.password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      print(resp.res);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(resp.res)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/background.jpg',
          ),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                //padding: const EdgeInsets.only(left: 30, right: 30, top: 70),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'WELCOME!!           ',
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                            flex: 8,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffdfbf9f),
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(),
                                      ),
                                      hintText: 'E-mail ID',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty)
                                        return 'Please Enter valid text';
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        _Data.email = val;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffdfbf9f),
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(),
                                      ),
                                      // labelText: 'E-mail ID',
                                      hintText: 'Password',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty)
                                        return 'Please Enter a valid password';
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        _Data.password = val;
                                      });
                                    },
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text('Forgot Password?',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(const SnackBar(
                                          //         content:
                                          //             Text('Processing data')));
                                          _loginRequest();
                                          setState(() {});
                                        }
                                      },
                                      child: Text(
                                        '    Sign In    ',
                                        style: TextStyle(fontSize: 20),
                                      ))
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 4,
                            child: Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Or Sign In with'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 36.0,
                                          child: Image.asset(
                                            'assets/gmail_icon.png',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.facebook,
                                          color: Colors.blue,
                                          size: 36,
                                        )
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Don\'t have an account?'),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const RegisterPage(),
                                              ),
                                            );
                                          },
                                          child: Text('Sign Up here',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                        )
                                      ],
                                    )
                                  ]),
                            )),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _LoginData {
  String email = '';
  String password = '';
}

class Response {
  String res;
  Response({required this.res});

  factory Response.fromJson(dynamic json) {
    return Response(res: json['Success'] as String);
  }
}
