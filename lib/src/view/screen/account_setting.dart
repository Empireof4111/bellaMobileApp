import 'package:flutter/material.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});
  static String routeName = "/account-setting";

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Wishlist',
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Notifications",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              // trailing: ToggleButtons(children: children, isSelected: isSelected)
            ),
            ListTile(
              title: Text(
                "Language Settings",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              // trailing: ToggleButtons(children: children, isSelected: isSelected)
            ),
            ListTile(
              title: Text(
                "Contact Us",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              // trailing: ToggleButtons(children: children, isSelected: isSelected)
            ),
            ListTile(
              title: Text(
                "Helps",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              // trailing: ToggleButtons(children: children, isSelected: isSelected)
            ),
            ListTile(
              title: Text(
                "Terms and Condition",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              // trailing: ToggleButtons(children: children, isSelected: isSelected)
            ),
            ListTile(
              title: Text(
                "Privacy and Policy",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              // trailing: ToggleButtons(children: children, isSelected: isSelected)
            ),
          ],
        ),
      ),
    );
  }
}
