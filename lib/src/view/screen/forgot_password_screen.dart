// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:bella_banga/core/constant.dart';
import 'package:bella_banga/core/custom_surfix_icon.dart';
import 'package:bella_banga/core/default_button.dart';
import 'package:bella_banga/core/form_error.dart';
import 'package:bella_banga/core/keyboard.dart';
import 'package:bella_banga/src/services/auth_services.dart';
import 'package:bella_banga/core/size_config.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
   const ForgotPasswordScreen({super.key});
  static const String routeName = '/Forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
final _formKey = GlobalKey<FormState>();
AuthService authService = AuthService();
final TextEditingController _emailController = TextEditingController();

  bool isLoading = false;

@override
  void dispose() {
  super.dispose();
  _emailController.dispose();
  }

  void forgotPassword() async {
    authService.regenarateOtp(context: context, email: _emailController.text);
  }

    List<String> errors = [];
     late String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text("Forgot Password",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Please enter your email and we will send \nyou a link to return to your account",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                
    Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController ,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue!,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              // ignore: avoid_returning_null_for_void
              return null;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          isLoading  ?  const Center(child: MyProgressor(),):  DefaultButton(
            text: "Continue",
            press: () async {
             if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                       setState(() {
                        isLoading = true;
                      });
                      forgotPassword();

                     await Future.delayed(const Duration(seconds: 5));
                  setState(() {
                    isLoading = false;
                  });
                        
                      // ignore: use_build_context_synchronously
                      KeyboardUtil.hideKeyboard(context);
                    }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          // NoAccountText(),
        ],
      ),
    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

