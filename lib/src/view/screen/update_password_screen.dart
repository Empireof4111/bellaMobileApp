// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/core/keyboard.dart';
import 'package:bella_banga/src/services/auth_services.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:flutter/material.dart';

import 'package:bella_banga/core/constant.dart';
import 'package:bella_banga/core/custom_surfix_icon.dart';
import 'package:bella_banga/core/default_button.dart';
import 'package:bella_banga/core/form_error.dart';
import 'package:bella_banga/core/size_config.dart';

class UpdatePasswordScreen extends StatefulWidget {
  final String email;
  const UpdatePasswordScreen({
    super.key,
    required this.email,
  });
  static const String routName = '/Update-Password';

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  void changePassword() {
    authService.updatePassword(
        context: context,
        email: widget.email,
        password: _passwordController.text);
  }

  String? password;
  String? conform_password;
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

  bool isLoading = false;
  var isObscured;
  @override
  void initState() {
    super.initState();
    isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.lightOrange,
          title: const Text('Update password',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
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
                    "Update Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Enter your new password and confirm the password to update",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  //form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          obscureText: isObscured,
                          onSaved: (newValue) => password = newValue,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kPassNullError);
                            } else if (value.length >= 8) {
                              removeError(error: kShortPassError);
                            }
                            // ignore: avoid_returning_null_for_void
                            return null;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              addError(error: kPassNullError);
                              return "";
                            } else if (value.length < 8) {
                              addError(error: kShortPassError);
                              return "";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter your new password",
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
                        TextFormField(
                          obscureText: isObscured,
                          onSaved: (newValue) => conform_password = newValue,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kPassNullError);
                            } else if (value.isNotEmpty &&
                                password == conform_password) {
                              removeError(error: kMatchPassError);
                            }
                            conform_password = value;
                          },
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     addError(error: kPassNullError);
                          //     return "";
                          //   } else if ((password != value)) {
                          //     addError(error: kMatchPassError);
                          //     return "";
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            hintText: "Re-enter your new password",
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
                        FormError(errors: errors),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        isLoading
                            ? const Center(
                                child: MyProgressor(),
                              )
                            : DefaultButton(
                                text: "Update",
                                press: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    setState(() {
                                      isLoading = true;
                                    });
                                    KeyboardUtil.hideKeyboard(context);
                                    changePassword();
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
