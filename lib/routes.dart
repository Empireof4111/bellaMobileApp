import 'package:bella_banga/src/model/productModel.dart';
import 'package:bella_banga/src/view/screen/about_us_screen.dart';
import 'package:bella_banga/src/view/screen/cart_screen.dart';
import 'package:bella_banga/src/view/screen/category_screen.dart';
import 'package:bella_banga/src/view/screen/chat_Screen.dart';
import 'package:bella_banga/src/view/screen/checkout_screen.dart';
import 'package:bella_banga/src/view/screen/contact_us.dart';
import 'package:bella_banga/src/view/screen/customer_support_screen.dart';
import 'package:bella_banga/src/view/screen/edit_passoword_screen.dart';
import 'package:bella_banga/src/view/screen/edit_profile_screen.dart';
import 'package:bella_banga/src/view/screen/faqs.dart';
import 'package:bella_banga/src/view/screen/forgot_password_screen.dart';
import 'package:bella_banga/src/view/screen/home_screen.dart';
import 'package:bella_banga/src/view/screen/login_screen.dart';
import 'package:bella_banga/src/view/screen/my_address-Screen.dart';
import 'package:bella_banga/src/view/screen/my_orders_screen.dart';
import 'package:bella_banga/src/view/screen/onboarding_screen.dart';
import 'package:bella_banga/src/view/screen/otp_screen.dart';
import 'package:bella_banga/src/view/screen/product_by_category_screen.dart';
import 'package:bella_banga/src/view/screen/product_by_vendor_screen.dart';
import 'package:bella_banga/src/view/screen/product_detail_screen.dart';
import 'package:bella_banga/src/view/screen/profile_screen.dart';
import 'package:bella_banga/src/view/screen/sign_up_screen.dart';
import 'package:bella_banga/src/view/screen/track_order_screen.dart';
import 'package:bella_banga/src/view/screen/update_password_otp.dart';
import 'package:bella_banga/src/view/screen/update_password_screen.dart';
import 'package:bella_banga/src/view/screen/vendor_screen.dart';
import 'package:bella_banga/src/view/screen/wishlist_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case OnBoardingScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OnBoardingScreen(),
      );
    case LoginScreen.routeName:
      String myFirstLogin = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => LoginScreen(myFirstLogin: myFirstLogin),
      );
    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ForgotPasswordScreen(),
      );
    case UpdatePasswordScreen.routName:
      var email = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => UpdatePasswordScreen(
          email: email,
        ),
      );
    case SignUpScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const HomeScreen(),
      );
    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartScreen(),
      );
    case CheckoutScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CheckoutScreen(),
      );
    case CategoryScreen.routName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CategoryScreen(),
      );
    case VendorScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const VendorScreen(),
      );
    case ProductByVendorScreen.routeName:
      int vendorId = routeSettings.arguments as int;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductByVendorScreen(
                vendorId: vendorId,
              ));
    case ProductByCategoryScreen.routeName:
      var categoryId = routeSettings.arguments as int;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductByCategoryScreen(categoryId: categoryId),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(product),
      );
    case ProfileScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProfileScreen(),
      );
    case EditPasswordScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const EditPasswordScreen());
    case EditProfileScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const EditProfileScreen());
    case MyAdressScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MyAdressScreen(),
      );
    case MyOrderScreen.routeName:
      int userId = routeSettings.arguments as int;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => MyOrderScreen(userId: userId),
      );
    case TrackOrderScreen.routeName:
      int orderID = routeSettings.arguments as int;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => TrackOrderScreen(orderId: orderID),
      );
    case WishlistScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const WishlistScreen(),
      );
    case OtpScreen.routeName:
      var email = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OtpScreen(
          email: email,
        ),
      );
    case UpdatePasswordOtp.routeName:
      var email = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => UpdatePasswordOtp(
          email: email,
        ),
      );
    case CustomerSupportScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CustomerSupportScreen(),
      );
    case AboutUsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AboutUsScreen(),
      );
    case ContactUsScrenn.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ContactUsScrenn(),
      );
    case FaqsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FaqsScreen(),
      );
    case ChatScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ChatScreen(),
      );
    default:
      return MaterialPageRoute(
        // ignore: prefer_const_constructors
        builder: (_) => Scaffold(
          body: const Center(child: Text("The page is not available")),
        ),
      );
  }
}
