import 'package:flutter/material.dart';

class ChenheTheme extends StatefulWidget {
  const ChenheTheme({super.key});

  @override
  State<ChenheTheme> createState() => _ChenheThemeState();
}

enum SingingCharacter { lafayette, jefferson }

class _ChenheThemeState extends State<ChenheTheme> {
  SingingCharacter? _character = SingingCharacter.lafayette;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Light Mode'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.lafayette,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Dark Mode'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.jefferson,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
