import 'dart:io';

import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/core/constant.dart';
import 'package:bella_banga/core/custom_surfix_icon.dart';
import 'package:bella_banga/core/default_button.dart';
import 'package:bella_banga/core/form_error.dart';
import 'package:bella_banga/core/keyboard.dart';
import 'package:bella_banga/core/size_config.dart';
import 'package:bella_banga/src/model/userModel.dart';
import 'package:bella_banga/src/provider/user_provider.dart';
import 'package:bella_banga/src/services/auth_services.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/edit-profile';
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    _addressController.dispose();
  }

  late String fullName;
  late String phoneNumber;
  late String country;
  late String city;
  late String email;
  late String address;

  void updateProfile() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    authService.editProfile(
        context: context,
        id: user.id.toString(),
        name: _fullNameController.text,
        phone: _phoneNumberController.text,
        email: _emailController.text,
        dpLink: _pickedImage.toString(),
        country: selectedCountry.toString(),
        city: selectedCity.toString(),
        address: _addressController.text);
  }

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

  File? _pickedImage;

  Future<void> pickImage() async {
    try {
      var file = await FilePicker.platform.pickFiles(type: FileType.image);
      if (file != null && file.files.isNotEmpty) {
        setState(() {
          _pickedImage = File(file.files.first.path!);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String? selectedCountry;
  String? selectedCity;

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
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      _pickedImage == null
                          ? const CircleAvatar(
                              radius: 100,
                              backgroundImage:
                                  AssetImage("assets/images/logo002.png"),
                            )
                          : CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(_pickedImage!),
                            ),
                      Positioned(
                        right: -16,
                        bottom: 0,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(color: Colors.white),
                              ),
                              backgroundColor: const Color(0xFFF5F6F9),
                            ),
                            onPressed: () {
                              pickImage();
                            },
                            child: SvgPicture.asset(
                                "assets/icons/Camera Icon.svg"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Update your profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _fullNameController,
                  onSaved: (newValue) => fullName = newValue!,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kNamelNullError);
                    }
                    return;
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
                    suffixIcon:
                        CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
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
                    return;
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
                    suffixIcon:
                        CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
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
                    return;
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
                    suffixIcon:
                        CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
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
                        value: "United Kingdom", child: Text('United Kingdom')),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      selectedCountry = value;
                      selectedCity = null; // Reset city when country changes
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
                      ? getStatesByCountry(selectedCountry!).map((String city) {
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
                    return;
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
                    hintText: "Enter your phone address",
                    suffixIcon: CustomSurffixIcon(
                        svgIcon: "assets/icons/Location point.svg"),
                  ),
                ),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(40)),
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
                            updateProfile();
                            // Navigator.pushNamed(context, HomeScreen.routeName);
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
