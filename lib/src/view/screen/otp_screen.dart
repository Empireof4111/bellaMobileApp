// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/core/constant.dart';
import 'package:bella_banga/core/default_button.dart';
import 'package:bella_banga/core/keyboard.dart';
import 'package:bella_banga/src/services/auth_services.dart';
import 'package:bella_banga/core/size_config.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final email;
  const OtpScreen({super.key, required this.email});
  static const String routeName = '/Otp-Screen';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _node1Controller = TextEditingController();
  final TextEditingController _node2Controller = TextEditingController();
  final TextEditingController _node3Controller = TextEditingController();
  final TextEditingController _node4Controller = TextEditingController();
  final TextEditingController _node5Controller = TextEditingController();
  final TextEditingController _node6Controller = TextEditingController();

  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;
  FocusNode? pin7FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
    pin7FocusNode?.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  void VerifyUser() {
    authService.verifyUser(
      toScreen: 'signUp',
      context: context,
      email: widget.email,
      otp:
          '${_node1Controller.text}${_node2Controller.text}${_node3Controller.text}${_node4Controller.text}${_node5Controller.text}${_node6Controller.text}',
    );
  }

  void RegenerateOtp() {
    authService.regenarateOtp(context: context, email: widget.email);
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "OTP Verification",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  const Text(
                    "We sent your code to",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(widget.email),
                  // buildTimer(),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: getProportionateScreenWidth(50),
                              child: TextFormField(
                                controller: _node1Controller,
                                autofocus: true,
                                obscureText: true,
                                style: const TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: otpInputDecoration,
                                onChanged: (value) {
                                  nextField(value, pin2FocusNode);
                                },
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(50),
                              child: TextFormField(
                                controller: _node2Controller,
                                focusNode: pin2FocusNode,
                                obscureText: true,
                                style: const TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: otpInputDecoration,
                                onChanged: (value) =>
                                    nextField(value, pin3FocusNode),
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(50),
                              child: TextFormField(
                                controller: _node3Controller,
                                focusNode: pin3FocusNode,
                                obscureText: true,
                                style: const TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: otpInputDecoration,
                                onChanged: (value) =>
                                    nextField(value, pin4FocusNode),
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(50),
                              child: TextFormField(
                                controller: _node4Controller,
                                focusNode: pin4FocusNode,
                                obscureText: true,
                                style: const TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: otpInputDecoration,
                                onChanged: (value) =>
                                    nextField(value, pin5FocusNode),
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(50),
                              child: TextFormField(
                                controller: _node5Controller,
                                focusNode: pin5FocusNode,
                                obscureText: true,
                                style: const TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: otpInputDecoration,
                                onChanged: (value) =>
                                    nextField(value, pin6FocusNode),
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(50),
                              child: TextFormField(
                                controller: _node6Controller,
                                focusNode: pin6FocusNode,
                                obscureText: true,
                                style: const TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: otpInputDecoration,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    pin4FocusNode!.unfocus();
                                    // Then you need to check is the code is correct or not
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.15),
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
                                    VerifyUser();
                                    await Future.delayed(
                                        const Duration(seconds: 5));
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
                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  GestureDetector(
                    onTap: () {
                      RegenerateOtp();
                      showSnackBar(context, "OTP Sent");
                    },
                    child: const Text(
                      "Resend OTP Code",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

Row buildTimer() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("This code will expired in "),
      TweenAnimationBuilder(
        tween: Tween(begin: 30.0, end: 0.0),
        duration: const Duration(seconds: 30),
        builder: (_, dynamic value, child) => Text(
          "00:${value.toInt()}",
          style: const TextStyle(color: AppColor.darkOrange),
        ),
      ),
    ],
  );
}
