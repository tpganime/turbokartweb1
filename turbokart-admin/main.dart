import 'package:turbokart_admin/screens/home_screen.dart';
import 'package:turbokart_admin/screens/admin_users.dart';
import 'package:turbokart_admin/screens/categories_screen.dart';
import 'package:turbokart_admin/screens/deliveryBoy_screen.dart';
import 'package:turbokart_admin/screens/login_screen.dart';
import 'package:turbokart_admin/screens/manage_banners.dart';
import 'package:turbokart_admin/screens/notification_screen.dart';
import 'package:turbokart_admin/screens/orders_screen.dart';
import 'package:turbokart_admin/screens/settings_screen.dart';
import 'package:turbokart_admin/screens/splash_screen.dart';
import 'package:turbokart_admin/screens/vendors_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      // These values are injected at build time via --dart-define
      // Set them as Environment Variables in Vercel Dashboard
      apiKey: String.fromEnvironment('FIREBASE_API_KEY'),
      authDomain: String.fromEnvironment('FIREBASE_AUTH_DOMAIN'),
      appId: String.fromEnvironment('FIREBASE_APP_ID'),
      messagingSenderId: String.fromEnvironment('FIREBASE_SENDER_ID'),
      projectId: String.fromEnvironment('FIREBASE_PROJECT_ID'),
      storageBucket: String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      builder: EasyLoading.init(),
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        SplashScreen.id: (context) => const SplashScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        BannerScreen.id: (context) => const BannerScreen(),
        CategoriesScreen.id: (context) => const CategoriesScreen(),
        OrderScreen.id: (context) => const OrderScreen(),
        NotificationScreen.id: (context) => const NotificationScreen(),
        AdminUsers.id: (context) => const AdminUsers(),
        SettingScreen.id: (context) => const SettingScreen(),
        VendorScreen.id: (context) => const VendorScreen(),
        DeliveryBoyScreen.id: (context) => const DeliveryBoyScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurple),
      title: "TurboKart Admin",
    );
  }
}
