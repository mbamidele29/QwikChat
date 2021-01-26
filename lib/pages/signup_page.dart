import 'package:QwikChat/controller/user_controller.dart';
import 'package:QwikChat/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  UserController _userController;
  TextEditingController _emailController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  Future<void> checkStatus() async {
    bool status = await _userController.getUser() != null;
    if (status) Navigator.pushReplacementNamed(context, '/chats');
  }

  @override
  void initState() {
    _userController = UserController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();

    // check if user is logged in
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Builder(builder: (ctx) {
          return Stack(
            children: [
              _background(),
              Positioned(
                bottom: 10,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 50, left: 30, right: 30, bottom: 10),
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _text("USERNAME"),
                                      _editText("username", _usernameController,
                                          validator: (value) {
                                        if (value.trim().length < 6)
                                          return "minimum of 6 characters";
                                        else
                                          return null;
                                      }, enabled: !isLoading),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      _text("EMAIL"),
                                      _editText("Email", _emailController,
                                          validator: (value) {
                                        String email = value.trim();
                                        if (email.isEmpty)
                                          return "Email is required";
                                        bool emailValid = RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(email);
                                        if (!emailValid)
                                          return "Value must be an email address";
                                        return null;
                                      }, enabled: !isLoading),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      _text("PASSWORD"),
                                      _editText(
                                        "password",
                                        _passwordController,
                                        validator: (value) {
                                          if (value.length < 6)
                                            return "minimum of 6 characters";
                                          else
                                            return null;
                                        },
                                        enabled: !isLoading,
                                        obscureText: true,
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  )),
                            ),
                            Container(
                              color: CustomColor.color1,
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (!isLoading) {
                                        if (_formKey.currentState.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          bool result =
                                              await _userController.signup(
                                            _usernameController.text.trim(),
                                            _emailController.text.trim(),
                                            _passwordController.text.trim(),
                                          );

                                          setState(() {
                                            isLoading = false;
                                          });

                                          if (result) {
                                            Navigator.pop(context);
                                          }
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 2, color: Colors.white)),
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "-Developed with passion-",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              isLoading
                  ? Center(
                      child: SpinKitFadingCircle(
                        color: CustomColor.color3,
                      ),
                    )
                  : SizedBox()
            ],
          );
        }),
      ),
    );
  }
}

Widget _editText(final String hintText, TextEditingController controller,
    {bool obscureText = false, bool enabled = true, Function validator}) {
  return TextFormField(
    enabled: enabled,
    controller: controller,
    obscureText: obscureText,
    validator: validator,
    style: TextStyle(color: Colors.black, fontSize: 18),
    decoration: InputDecoration(
      hintText: hintText,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
  );
}

Widget _text(String text) {
  return Text(
    text,
    style: TextStyle(
      letterSpacing: 1,
      color: CustomColor.color3,
    ),
  );
}

Widget _background() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 3,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  CustomColor.color1,
                  CustomColor.color2,
                ],
                stops: [
                  0.6,
                  0.6
                ]),
          ),
          child: Center(
            child: Icon(
              Icons.chat,
              color: CustomColor.color3,
              size: 80,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Container(
          width: double.infinity,
          color: Colors.black,
        ),
      ),
    ],
  );
}
