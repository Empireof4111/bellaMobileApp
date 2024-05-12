// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_returning_null_for_void, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/core/constant.dart';
import 'package:bella_banga/core/custom_surfix_icon.dart';
import 'package:bella_banga/core/default_button.dart';
import 'package:bella_banga/core/form_error.dart';
import 'package:bella_banga/core/keyboard.dart';
import 'package:bella_banga/core/size_config.dart';
import 'package:bella_banga/core/social_card.dart';
import 'package:bella_banga/src/services/auth_services.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:bella_banga/src/view/screen/forgot_password_screen.dart';
import 'package:bella_banga/src/view/screen/sign_up_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  late String myFirstLogin;
  LoginScreen({
    super.key,
    required this.myFirstLogin,
  });
  static const String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void SignIn() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      firstLogin: widget.myFirstLogin,
    );
  }

  late String email;
  late String password;
  bool? remember = false;

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  var isObscured;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // appBar: AppBar(
      //     foregroundColor: Colors.white,
      //     backgroundColor: AppColor.lightOrange,
      //     title: const Text('Sign Up',
      //         style: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.white))),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Image.asset(
                    'assets/images/logo.jpg',
                    width: 100,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign in with your email and password  \nor continue with social media",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  //form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (newValue) => email = newValue!,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kEmailNullError);
                            } else if (emailValidatorRegExp.hasMatch(value)) {
                              removeError(error: kInvalidEmailError);
                            }
                            return null;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              addError(error: kEmailNullError);
                              return "";
                            } else if (!emailValidatorRegExp.hasMatch(value)) {
                              addError(error: kInvalidEmailError);
                              return "";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter your email",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(
                                svgIcon: "assets/icons/Mail.svg"),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: isObscured,
                          onSaved: (newValue) => password = newValue!,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kPassNullError);
                            } else if (value.length >= 8) {
                              removeError(error: kShortPassError);
                            }
                            return null;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              addError(error: kPassNullError);
                              return "";
                            } else if (value.length < 2) {
                              addError(error: kShortPassError);
                              return "";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter your password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObscured = !isObscured;
                                });
                              },
                              child: CustomSurffixIcon(
                                  svgIcon: isObscured
                                      ? "assets/icons/iconmonstr-eye-off-thin.svg"
                                      : "assets/icons/iconmonstr-eye-thin.svg"),
                            ),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        Row(
                          children: [
                            Checkbox(
                              value: remember,
                              activeColor: AppColor.darkOrange,
                              onChanged: (value) {
                                setState(() {
                                  remember = value;
                                });
                              },
                            ),
                            Text("Remember me"),
                            Spacer(),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, ForgotPasswordScreen.routeName),
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                        FormError(errors: errors),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        isLoading
                            ? Center(
                                child: MyProgressor(),
                              )
                            : DefaultButton(
                                text: "Continue",
                                press: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    setState(() {
                                      isLoading = true;
                                    });
                                    SignIn();
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    setState(() {
                                      isLoading = false;
                                    });
                                    // ignore: use_build_context_synchronously
                                    KeyboardUtil.hideKeyboard(context);
                                  }
                                },
                              )
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  // NoAccountText(),
                  Text(
                    "Don’t have an account? ",
                    style: TextStyle(fontSize: getProportionateScreenWidth(16)),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, SignUpScreen.routeName),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(16),
                          color: AppColor.darkOrange),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
