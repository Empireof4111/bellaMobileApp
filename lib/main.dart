import 'dart:io';
import 'dart:ui' show PointerDeviceKind;
import 'package:bella_banga/boxes.dart';
import 'package:bella_banga/routes.dart';
import 'package:bella_banga/src/model/local_storage_model/addtocartmodel.dart';
import 'package:bella_banga/src/provider/user_provider.dart';
import 'package:bella_banga/src/view/screen/home_screen.dart';
import 'package:bella_banga/src/view/screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:bella_banga/core/app_theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

bool show = true;
void main() async {
  HttpOverrides.global=MyHttpoverrides();
  await Hive.initFlutter();
  Hive.registerAdapter(AddtocartmodelAdapter());
  cartBox = await Hive.openBox<Addtocartmodel>('AddcartBox');
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  show = pref.getBool('ON_BOARDING') ?? true;
  UserProvider userProvider = UserProvider();
  if (await userProvider.isLoggedIn) {
    await userProvider.loadUserFromSharedPreferences();
  }

  // DependencyInjection.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: userProvider),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightAppTheme,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: show ? const OnBoardingScreen() : const HomeScreen(),
    );
  }
}
