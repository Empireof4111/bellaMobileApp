import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/src/view/screen/contact_us.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  static const String routeName = '/about-us';
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.lightOrange,
          title: const Text('About Us',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  text: 'What is BellaBanga all about?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            '\n\nWe are a trusted partner for local vendors looking to tap into the global economy. Our mission is to empower artisans, farmers, and entrepreneurs by providing them with a trustworthy platform to export their goods worldwide and receive payments seamlessly. We are equally committed to earning the trust of consumers worldwide by offering easy access to genuine African products. Bellabanga is a here trust meets global commerce.',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ContactUsScrenn.routeName);
                },
                style: const ButtonStyle(
                    elevation: MaterialStatePropertyAll(0.0),
                    backgroundColor:
                        MaterialStatePropertyAll(AppColor.lightOrange)),
                child: const Text(
                  "Contact Us",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'Our Vision',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            '\n\nOur vision at Bellabanga is to be the most trusted and reliable global platform for connecting African vendors with international markets. We strive to create a world where trust is the cornerstone of every interaction, and where every local vendor can confidently access the global economy. We want to build trust across continents and cultures through commerce.',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'Our Mission',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            '\n\nAt Bellabanga, our mission is to provide a secure and trustworthy e-commerce platform that empowers local vendors to expand their businesses globally, receive payments in foreign currencies, and gain the trust of customers worldwide. We are dedicated to fostering trust in African entrepreneurship, promoting economic growth, and making African products accessible and trusted across the world. We aim to be the bridge of trust that connects local entrepreneurs with global opportunities.',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
