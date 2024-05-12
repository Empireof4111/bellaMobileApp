// ignore_for_file: file_names

import 'package:bella_banga/core/app_color.dart';
import 'package:flutter/material.dart';

class MyAdressScreen extends StatefulWidget {
  const MyAdressScreen({super.key});
  static const String routeName = "/my-address";
  @override
  State<MyAdressScreen> createState() => _MyAdressScreenState();
}

class _MyAdressScreenState extends State<MyAdressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Delivery Address',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          leading: GestureDetector(
            onTap: () => {
              Navigator.pop(
                context,
              )
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: 
        
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColor.lightGrey,
                      blurRadius: 25.0, // soften the shadow
                      spreadRadius: 1.0, //extend the shadow
                      offset: Offset(
                        0.0, // Move to right 10  horizontally
                        0.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColor.lightGrey,
                                  blurRadius: 25.0, // soften the shadow
                                  spreadRadius: 1.0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    0.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                            child: const Icon(
                              Icons.home,
                              color: AppColor.darkOrange,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Delivery Address",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Kano State',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'No. 31 BUK Road Behind Zone One, Police Barrack Kano ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () => {},
                style: const ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(Size(327, 45)),
                ),
                child: const Text(
                  '+ Add New Address',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )
        
        );
  }
}
