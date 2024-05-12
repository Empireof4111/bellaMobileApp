import 'package:bella_banga/core/app_color.dart';
import 'package:flutter/material.dart';

class FaqsScreen extends StatelessWidget {
  static const String routeName = 'faqs';
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColor.lightOrange,
        title: const Text( 'FAQs', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
            ExpansionTile(
            title: Text('Foundation and Inception', style: TextStyle(fontWeight: FontWeight.bold),),
            // subtitle: Text('Trailing expansion arrow icon'),
            children: <Widget>[
              ListTile(title: Text('When was Bellabanga established? Bellabanga was founded in the year 2023 as an online marketplace, specifically designed as a mobile application. It serves as a platform for small Nigerian exporters and entrepreneurs to connect with global buyers.')),
            ],
          ),
          ExpansionTile(
            title: Text('Business Registration', style: TextStyle(fontWeight: FontWeight.bold),),
            // subtitle: Text('Trailing expansion arrow icon'),
            children: <Widget>[
              ListTile(title: Text('Is business registration mandatory? Yes, business registration is required, although it is not mandatory for selling on the platform.')),
            ],
          ),
          ExpansionTile(
            title: Text('Identity Verification', style: TextStyle(fontWeight: FontWeight.bold),),
            // subtitle: Text('Trailing expansion arrow icon'),
            children: <Widget>[
              ListTile(title: Text('Do I need to verify my identity? Yes, identity verification is mandatory for vendors on Bellabanga. This measure is essential to establish trust among global buyers and to mitigate the risk of fraudulent activities on the platform.')),
            ],
          ),
          ExpansionTile(
            title: Text('Shipping Responsibilities', style: TextStyle(fontWeight: FontWeight.bold),),
            // subtitle: Text('Trailing expansion arrow icon'),
            children: <Widget>[
              ListTile(title: Text('Does Bellabanga handle shipping? No, Bellabanga does not manage shipping. Vendors are responsible for shipping their goods. The app, however, provides a tracking feature for buyers to monitor their orders. A list of suggested logistics companies will also be available on our website')),
            ],
          ),
            ],
          ),
        ),
      ),
    );
  }
}