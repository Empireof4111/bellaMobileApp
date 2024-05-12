// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: deprecated_member_use

import 'package:bella_banga/core/size_config.dart';
import 'package:bella_banga/src/view/screen/about_us_screen.dart';
import 'package:bella_banga/src/view/screen/contact_us.dart';
import 'package:bella_banga/src/view/screen/customer_support_screen.dart';
import 'package:bella_banga/src/view/screen/edit_passoword_screen.dart';
import 'package:bella_banga/src/view/screen/edit_profile_screen.dart';
import 'package:bella_banga/src/view/screen/faqs.dart';
import 'package:bella_banga/src/view/screen/home_screen.dart';
import 'package:bella_banga/src/view/screen/login_screen.dart';
import 'package:bella_banga/src/view/widget/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/src/provider/user_provider.dart';
import 'package:bella_banga/src/services/auth_services.dart';
import 'package:bella_banga/src/view/screen/account_setting.dart';
import 'package:bella_banga/src/view/screen/my_orders_screen.dart';
import 'package:bella_banga/src/view/screen/wishlist_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String routeName = "/Profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService authService = AuthService();

  void logOut() async {
    authService.signOutUser(context);
    setState(() {});
  }

  void _showBottomSheet(BuildContext context) {
    // Show BottomSheet
    showModalBottomSheet(
      useSafeArea: true,
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        SizeConfig().init(context);
        return const SizedBox(height: 200, child: ChenheTheme());
      },
    );
  }

  Future<bool> isUserLoging() async {
    UserProvider userProvider = UserProvider();
    return userProvider.user.id == null ||
        userProvider.user.name!.isEmpty ||
        !(await userProvider.isLoggedIn);
  }

  navigateToLoginScreen() {
    return Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    return isUserLoging == false
        ? navigateToLoginScreen()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.lightOrange,
              title: const Text(
                'Profile',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            body: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                final user = userProvider.user;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: Stack(
                                  fit: StackFit.expand,
                                  clipBehavior: Clip.none,
                                  children: [
                                    CircleAvatar(
                                      radius: 100,
                                      backgroundImage: const AssetImage(
                                          "assets/images/profile_pic.png"),
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.5),
                                    ),

                                    // Positioned(
                                    //   right: -16,
                                    //   bottom: 0,
                                    //   child: SizedBox(
                                    //     height: 46,
                                    //     width: 46,
                                    //     child: TextButton(
                                    //       style: TextButton.styleFrom(
                                    //         foregroundColor: Colors.white, shape: RoundedRectangleBorder(
                                    //           borderRadius: BorderRadius.circular(50),
                                    //           side: BorderSide(color: Colors.white),
                                    //         ),
                                    //         backgroundColor: Color(0xFFF5F6F9),
                                    //       ),
                                    //       onPressed: () {},
                                    //       child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Hello!",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("${user.name}",
                                      style: const TextStyle(fontSize: 18)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListTileWidget(
                            leadingIcon: "assets/icons/User.svg",
                            titleText: "Personal info",
                            press: () {
                              Navigator.pushNamed(
                                  context, EditProfileScreen.routeName);
                            },
                          ),
                          const SizedBox(height: 5),
                          ListTileWidget(
                              leadingIcon: "assets/icons/shopping-bag.svg",
                              titleText: "My Order",
                              press: () {
                                Navigator.pushNamed(
                                    context, MyOrderScreen.routeName,
                                    arguments: user.id);
                              }),
                          const SizedBox(height: 5),
                          ListTileWidget(
                              leadingIcon: "assets/icons/Heart Icon.svg",
                              titleText: "My Wishlist",
                              press: () {
                                Navigator.pushNamed(
                                    context, WishlistScreen.routeName);
                              }),
                          const SizedBox(height: 5),
                          ListTileWidget(
                              leadingIcon: "assets/icons/customer-services.svg",
                              titleText: "Customer Support",
                              press: () {
                                Navigator.pushNamed(
                                    context, CustomerSupportScreen.routeName);
                              }),
                          const SizedBox(height: 5),
                          ListTileWidget(
                              leadingIcon: "assets/icons/about-us.svg",
                              titleText: "About Us",
                              press: () {
                                Navigator.pushNamed(
                                    context, AboutUsScreen.routeName);
                              }),
                          const SizedBox(height: 5),
                          ListTileWidget(
                              leadingIcon: "assets/icons/contact-us.svg",
                              titleText: "Contact Us",
                              press: () {
                                Navigator.pushNamed(
                                    context, ContactUsScrenn.routeName);
                              }),
                          const SizedBox(height: 5),
                          ListTileWidget(
                              leadingIcon: "assets/icons/faqs.svg",
                              titleText: "Faqs",
                              press: () {
                                Navigator.pushNamed(
                                    context, FaqsScreen.routeName);
                              }),
                          const SizedBox(height: 5),
                          ListTileWidget(
                              leadingIcon: "assets/icons/privacy-policy.svg",
                              titleText: "Privacy Policy",
                              press: () {
                                Navigator.pushNamed(
                                    context, AccountSettingScreen.routeName);
                              }),
                          const SizedBox(height: 5),
                          ListTileWidget(
                              leadingIcon:
                                  "assets/icons/terms-and-condition.svg",
                              titleText: "Terms & Condition",
                              press: () {
                                Navigator.pushNamed(
                                    context, AccountSettingScreen.routeName);
                              }),
                          const SizedBox(height: 5),
                          ListTileWidget(
                              leadingIcon:
                                  "assets/icons/change-password-icon.svg",
                              titleText: "Update Password",
                              press: () {
                                Navigator.pushNamed(
                                    context, EditPasswordScreen.routeName);
                              }),
                          const SizedBox(height: 5),
                          ListTileWidget(
                              leadingIcon: "assets/icons/Settings.svg",
                              titleText: "Settings",
                              press: () {
                                _showBottomSheet(context);
                              }),
                          const SizedBox(height: 5),
                          ListTileWidget(
                              leadingIcon: "assets/icons/Logout.svg",
                              titleText: "Log out",
                              press: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.remove('user_data');
                                logOut();
                              }),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}

class ListTileWidget extends StatelessWidget {
  final String leadingIcon;
  final String titleText;
  final GestureTapCallback press;
  const ListTileWidget({
    super.key,
    required this.leadingIcon,
    required this.titleText,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: SvgPicture.asset(
        leadingIcon,
        height: 22,
        width: 22,
        color: AppColor.lightOrange,
      ),
      title: Text(
        titleText,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20,
        color: AppColor.lightOrange,
      ),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 0.5, color: Colors.grey.withOpacity(0.5))),
    );
  }
}
