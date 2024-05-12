import 'package:bella_banga/src/model/userModel.dart';
import 'package:bella_banga/src/provider/user_provider.dart';
import 'package:bella_banga/src/view/screen/category_screen.dart';
import 'package:bella_banga/src/view/screen/login_screen.dart';
import 'package:bella_banga/src/view/widget/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:bella_banga/core/app_data.dart';
import 'package:bella_banga/src/view/screen/cart_screen.dart';
import 'package:bella_banga/src/view/screen/profile_screen.dart';
import 'package:bella_banga/src/view/screen/product_list_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "/home";

  static const List<Widget> screens = [
    ProductListScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int newIndex = 0;

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return PageWrapper(
      child: Scaffold(
        bottomNavigationBar: BottomNavyBar(
          itemCornerRadius: 10,
          selectedIndex: newIndex,
          items: AppData.bottomNavyBarItems
              .map(
                (item) => BottomNavyBarItem(
                  icon: item.icon,
                  title: Text(item.title),
                  activeColor: item.activeColor,
                  inactiveColor: item.inActiveColor,
                ),
              )
              .toList(),
          onItemSelected: (currentIndex) async {
            // ignore: unnecessary_null_comparison
            UserProvider userProvider = UserProvider();
            if (currentIndex == 3 &&
                (user.id == null ||
                    user.name!.isEmpty ||
                    !(await userProvider.isLoggedIn))) {
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, LoginScreen.routeName,
                  arguments: 'fromProfile');
            } else {
              newIndex = currentIndex;
              setState(() {});
            }
          },
        ),
        body: HomeScreen.screens[newIndex],
      ),
    );
  }
}
