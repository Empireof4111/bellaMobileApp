// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, avoid_returning_null_for, avoid_returning_null_for_void

import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/core/constant.dart';
import 'package:bella_banga/core/custom_surfix_icon.dart';
import 'package:bella_banga/core/default_button.dart';
import 'package:bella_banga/core/form_error.dart';
import 'package:bella_banga/core/keyboard.dart';
import 'package:bella_banga/src/services/auth_services.dart';
import 'package:bella_banga/core/size_config.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:bella_banga/src/view/screen/login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = "/Sign-up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
  }

  void SignUp() {
    authService.signUpUser(
      context: context,
      name: _fullNameController.text,
      email: _emailController.text,
      phoneNumber: _phoneNumberController.text,
      password: _passwordController.text,
      country: selectedCountry.toString(),
      city: selectedCity.toString(),
    );
  }

  late String fullName;
  late String phoneNumber;
  late String country;
  late String city;
  late String email;
  late String address;
  late String password;
  late String conform_password;
  bool remember = false;

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

  String? selectedCountry;
  String? selectedCity;
  // ignore: prefer_typing_uninitialized_variables
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
          title: const Text('Sign Up',
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
                  // const SizedBox(height: 16),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Complete your details or continue \nwith social media",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),

                  //FORM BEGIN
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _fullNameController,
                          onSaved: (newValue) => fullName = newValue!,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kNamelNullError);
                            }
                            return null;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              addError(error: kNamelNullError);
                              return "";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Full Name",
                            hintText: "Enter your full name",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(
                                svgIcon: "assets/icons/User.svg"),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        TextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          onSaved: (newValue) => phoneNumber = newValue!,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kPhoneNumberNullError);
                            }
                            return null;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              addError(error: kPhoneNumberNullError);
                              return "";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Phone Number",
                            hintText: "Enter your phone number",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(
                                svgIcon: "assets/icons/Phone.svg"),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
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
                          decoration: const InputDecoration(
                            labelText: "Email",
                            hintText: "Enter your email",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(
                                svgIcon: "assets/icons/Mail.svg"),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: "Country",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(
                                svgIcon: "assets/icons/Location point.svg"),
                          ),
                          value: selectedCountry,
                          hint: const Text("-Select Country-"),
                          items: const [
                            DropdownMenuItem<String>(
                                value: "Nigeria", child: Text('Nigeria')),
                            DropdownMenuItem<String>(
                                value: "United Kingdom",
                                child: Text('United Kingdom')),
                          ],
                          onChanged: (String? value) {
                            setState(() {
                              selectedCountry = value;
                              selectedCity =
                                  null; // Reset city when country changes
                            });
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: "City",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(
                                svgIcon: "assets/icons/Location point.svg"),
                          ),
                          value: selectedCity,
                          hint: const Text("-Select City-"),
                          items: selectedCountry != null
                              ? getStatesByCountry(selectedCountry!)
                                  .map((String city) {
                                  return DropdownMenuItem<String>(
                                      value: city, child: Text(city));
                                }).toList()
                              : [],
                          onChanged: (String? value) {
                            setState(() {
                              selectedCity = value;
                            });
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        TextFormField(
                          controller: _addressController,
                          onSaved: (newValue) => address = newValue!,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kAddressNullError);
                            }
                            return null;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              addError(error: kAddressNullError);
                              return "";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Address",
                            hintText: "Enter your home address",
                            suffixIcon: CustomSurffixIcon(
                                svgIcon: "assets/icons/Location point.svg"),
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
                        SizedBox(height: getProportionateScreenHeight(20)),
                        TextFormField(
                          obscureText: isObscured,
                          onSaved: (newValue) => conform_password = newValue!,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kPassNullError);
                            } else if (value.isNotEmpty &&
                                password == conform_password) {
                              removeError(error: kMatchPassError);
                            }
                            conform_password = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              addError(error: kPassNullError);
                              return "";
                            } else if ((password != value)) {
                              addError(error: kMatchPassError);
                              return "";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            hintText: "Re-enter your password",
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
                                    SignUp();
                                    await Future.delayed(
                                        const Duration(seconds: 5));
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
                  //FORM ENDS

                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  // NoAccountText(),
                  Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: getProportionateScreenWidth(16)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.routeName,
                          arguments: "isAcountVerified");
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(16),
                          color: AppColor.darkOrange),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//FORMS FIELD
