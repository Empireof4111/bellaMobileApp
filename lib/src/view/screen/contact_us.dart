import 'package:bella_banga/core/app_color.dart';
import 'package:flutter/material.dart';

class ContactUsScrenn extends StatelessWidget {
  static const String routeName = '/contact-us';
  const ContactUsScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.lightOrange,
          title: const Text('Contact Us',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Fill the form below or write us .We will help you as soon as possible.',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.darkOrange,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 0.5, color: Colors.grey.withOpacity(0.5))),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.call,
                      color: Colors.white,
                      size: 50,
                    ),
                    Text(
                      "Phone",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "+234 704 785 0929",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.lightOrange,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 0.5, color: Colors.grey.withOpacity(0.5))),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mail,
                      color: Colors.white,
                      size: 50,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "bellabanga@gmail.com",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
