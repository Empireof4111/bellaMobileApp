import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/core/constant.dart';
import 'package:bella_banga/core/custom_surfix_icon.dart';
import 'package:bella_banga/core/default_button.dart';
import 'package:bella_banga/core/form_error.dart';
import 'package:bella_banga/core/keyboard.dart';
import 'package:bella_banga/core/size_config.dart';
import 'package:bella_banga/src/services/auth_services.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:flutter/material.dart';

class EditPasswordScreen extends StatefulWidget {
  static const String routeName = '/update-password';
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _oldpasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _oldpasswordController.dispose();
  }

  void changePassword() async {
    authService.changePassword(
        context: context,
        oldpassword: _oldpasswordController.text,
        password: _passwordController.text);
  }

  late String password;
  late String oldpassword;
  late String confirmpassword;

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
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.lightOrange,
          title: const Text('Edit Profile',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Update your password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextFormField(
                  controller: _oldpasswordController,
                  obscureText: isObscured,
                  onSaved: (newValue) => oldpassword = newValue!,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kPassNullError);
                    } else if (value.length >= 8) {
                      removeError(error: kShortPassError);
                    }
                    oldpassword = value;
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
                    labelText: "Old Password",
                    hintText: "Enter your old password",
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
                    // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
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
                    password = value;
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
                    labelText: "New Password",
                    hintText: "Enter your New password",
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
                SizedBox(height: getProportionateScreenHeight(20)),
                TextFormField(
                  // controller: _passwordController,
                  obscureText: isObscured,
                  onSaved: (newValue) => confirmpassword = newValue!,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kPassNullError);
                    } else if (value.length >= 8) {
                      removeError(error: kShortPassError);
                    }
                    confirmpassword = value;
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
                    labelText: "Confirm New Password",
                    hintText: "Enter your Confrm New password",
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
                SizedBox(height: getProportionateScreenHeight(20)),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(40)),
                isLoading
                    ? const Center(
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
                            changePassword();
                            await Future.delayed(const Duration(seconds: 5));
                            setState(() {
                              isLoading = false;
                            });
                            // ignore: use_build_context_synchronously
                            KeyboardUtil.hideKeyboard(context);
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
