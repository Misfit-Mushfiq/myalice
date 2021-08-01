import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/loginApiController.dart';
import 'package:myalice/utils/routes.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/constant_strings.dart';
import 'package:myalice/utils/shared_pref.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool passwordVisible;
  late bool showLoader;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final LoginApiController loginApiController = Get.put(LoginApiController());
  final SharedPref _sharedPref = SharedPref();

  @override
  void initState() {
    passwordVisible = true;
    showLoader = false;
    super.initState();
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
                    controller: _emailController,
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
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          )),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 20.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AliceColors.ALICE_GREEN,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: passwordVisible,
                  textAlign: TextAlign.start,
                  autofocus: false,
                  onChanged: (value) {},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Password",
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 20.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AliceColors.ALICE_GREEN,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
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
                  child: ElevatedButton(
                    /* shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ), */
                    style: ElevatedButton.styleFrom(
                        primary: AliceColors.ALICE_GREEN),
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
                    //color: AliceColors.ALICE_GREEN,
                    onPressed: () {
                      setState(() {
                        showLoader = !showLoader;
                      });
                      Get.find<LoginApiController>()
                          .login(
                              _emailController.text, _passwordController.text)
                          .then((value) {
                        if (value.success!) {
                          _sharedPref.saveString("apiToken", value.access);
                          //Get.offNamed('chatDetailsPage');
                          Get.offNamed(INBOX_PAGE);
                        } else {
                          final snackBar = SnackBar(
                            content: const Text("Error"),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                    },
                  ),
                ),
              ),
              if (showLoader)
                SpinKitChasingDots(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                          color: index.isEven ? Colors.yellow : Colors.green,
                          shape: BoxShape.circle),
                    );
                  },
                  size: 30,
                  duration: Duration(milliseconds: 1500),
                ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Need to sign up?',
                        style: TextStyle(color: AliceColors.ALICE_BLUE),
                      ),
                      onTap: () {
                        Get.toNamed(SIGNUP_PAGE);
                      },
                    ),
                    GestureDetector(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: AliceColors.ALICE_BLUE),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
