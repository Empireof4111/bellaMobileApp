import 'dart:io';

import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/core/constant.dart';
import 'package:bella_banga/core/custom_surfix_icon.dart';
import 'package:bella_banga/core/default_button.dart';
import 'package:bella_banga/core/form_error.dart';
import 'package:bella_banga/core/keyboard.dart';
import 'package:bella_banga/core/size_config.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomerSupportScreen extends StatefulWidget {
  static const String routeName = "/customer-support";
  const CustomerSupportScreen({super.key});

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _departmentController.dispose();
    _priorityController.dispose();
    _emailController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  late String fullName;
  late String phoneNumber;
  late String department;
  late String priority;
  late String email;
  late String title;
  late String description;

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

  bool isLoading = false;
  String? selectedDepartment;
  String? selectedPriority;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.lightOrange,
            title: const Text('Support Ticket',
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
                    'Submit A Ticket',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Fill the form below to submit a ticket or complain and submit with a document attachedd.',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
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
                    // initialValue: "Basiru",
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
                      labelText: "Department",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: CustomSurffixIcon(
                          svgIcon: "assets/icons/Location point.svg"),
                    ),
                    value: selectedDepartment,
                    hint: const Text("-Select Department-"),
                    items: const [
                      DropdownMenuItem<String>(
                          value: "Technical Support Desk",
                          child: Text('Technical Support Desk')),
                      DropdownMenuItem<String>(
                          value: "Customer Serivice Desk",
                          child: Text('Customer Serivice Desk')),
                      DropdownMenuItem<String>(
                          value: "Payment Serivice Desk",
                          child: Text('Payment Serivice Desk')),
                      DropdownMenuItem<String>(
                          value: "Abuse Department",
                          child: Text('Abuse Department')),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        selectedDepartment = value;
                      });
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Priority",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: CustomSurffixIcon(
                          svgIcon: "assets/icons/Location point.svg"),
                    ),
                    value: selectedPriority,
                    hint: const Text("-Select Priority-"),
                    items: const [
                      DropdownMenuItem<String>(
                          value: "LOW", child: Text('LOW')),
                      DropdownMenuItem<String>(
                          value: "MEDIUM", child: Text('MEDIUM')),
                      DropdownMenuItem<String>(
                          value: "HIGH", child: Text('HIGH')),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        selectedPriority = value;
                      });
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  TextFormField(
                    controller: _titleController,
                    onSaved: (newValue) => title = newValue!,
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
                      labelText: "Title",
                      hintText: "Enter title",
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  TextFormField(
                    maxLines: 6,
                    controller: _descriptionController,
                    onSaved: (newValue) => description = newValue!,
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
                      labelText: "Description",
                      hintText: "Enter description",
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          pickImage();
                        },
                        style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(0.0),
                            backgroundColor:
                                MaterialStatePropertyAll(AppColor.lightOrange)),
                        child: const Text(
                          "Upload file",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                          width: 200,
                          child: Text(
                            _pickedImage == null ? '' : _pickedImage.toString(),
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                  FormError(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(40)),
                  isLoading
                      ? const Center(
                          child: MyProgressor(),
                        )
                      : DefaultButton(
                          text: "Submit",
                          press: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() {
                                isLoading = true;
                              });
                              // updateProfile();
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
        ));
  }
}
