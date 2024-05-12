import 'package:flutter/material.dart';

class EmptyProductScreen extends StatelessWidget {
  const EmptyProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No products found!'),
      ),
    );
  }
}