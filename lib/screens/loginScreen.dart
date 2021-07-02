import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:myalice/utils/constant_strings.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool passwordVisible;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                LOGIN_SCREEN_TITLE,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: false,
                    validator: (value) {
                      return GetUtils.isEmail(value!)
                          ? null
                          : "Please enter valid Email";
                    },
                    decoration: InputDecoration(
                      hintText: "Email address",
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 20.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ALICE_GREEN,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: TextField(
                  obscureText: passwordVisible,
                  textAlign: TextAlign.start,
                  autofocus: false,
                  onChanged: (value) {},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Password",
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 20.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ALICE_GREEN,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ALICE_GREEN,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        passwordVisible == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        16.0,
                      ),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    color: ALICE_GREEN,
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              GestureDetector(
                child: Text(
                  'Forgot Password?',
                ),
                onTap: () {},
              ),
            ],
          ),
        ));
  }
}
