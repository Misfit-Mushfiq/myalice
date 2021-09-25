import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/loginApiController.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/constant_strings.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPassword> {
  late bool showLoader;
  TextEditingController _emailController = TextEditingController();
  late LoginApiController loginApiController;
  final _formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    loginApiController = Get.put(LoginApiController());
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
                FORGOT_PASSWORD_SCREEN_TITLE,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    fontFamily: "inter"),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                FORGOT_PASSWORD_SCREEN_SUBTITLE,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "inter"),
              ),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Form(
                       key: _formGlobalKey,
                    child: TextFormField(
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (email) {
                        if (GetUtils.isEmail(_emailController.text))
                          return null;
                        else
                          return 'Enter a valid email address';
                      },
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: "Email address",
                        errorStyle: TextStyle(fontSize: 12, height: 0.5),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 20.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AliceColors.ALICE_GREEN,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  )),
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
                        primary: AliceColors.ALICE_GREEN,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
                    child: Padding(
                      padding: EdgeInsets.all(
                        16.0,
                      ),
                      child: Text(
                        'Send Code',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold,fontFamily: "inter"),
                      ),
                    ),
                    //color: AliceColors.ALICE_GREEN,
                    onPressed: () {
                      if (_formGlobalKey.currentState!.validate()) {
                          _formGlobalKey.currentState!.save();
                          Get.find<LoginApiController>()
                              .forgotPassword(_emailController.text)
                              .then((value) {
                            if (value) {
                              setState(() {
                                showLoader = !showLoader;
                              });
                             // Get.offNamed(INBOX_PAGE);
                            }
                          });
                        }
                    },
                  ),
                ),
              ),
              if (showLoader)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SpinKitChasingDots(
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
                ),
/*               SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Facing an issue?',
                        style: TextStyle(
                            color: AliceColors.ALICE_BLUE,
                            fontWeight: FontWeight.bold,fontFamily: "inter"),
                      ),
                      onTap: () {
                        Get.toNamed(SIGNUP_PAGE);
                      },
                    ),
                   ],
                ),
              ) */
            ],
          ),
        ));
  }
}
