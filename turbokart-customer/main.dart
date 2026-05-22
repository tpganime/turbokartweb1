// ============================================================
// TurboKart Customer App — main.dart
// Replace ALL "multi_vending_grocery_app" imports below with
// "turbokart" after renaming the package in pubspec.yaml
// ============================================================
import 'package:turbokart/providers/authentication_provider.dart';
import 'package:turbokart/providers/cart_provider.dart';
import 'package:turbokart/providers/coupons_provider.dart';
import 'package:turbokart/providers/location_provider.dart';
import 'package:turbokart/providers/orders_provider.dart';
import 'package:turbokart/providers/store_provider.dart';
import 'package:turbokart/screens/cart_screen.dart';
import 'package:turbokart/screens/home_screen.dart';
import 'package:turbokart/screens/landing_screen.dart';
import 'package:turbokart/screens/login_screen.dart';
import 'package:turbokart/screens/main_screen.dart';
import 'package:turbokart/screens/map_screen.dart';
import 'package:turbokart/screens/my_orders_screen.dart';
import 'package:turbokart/screens/otp_verification_screen.dart';
import 'package:turbokart/screens/payments/razorpay/razorpay_payment.dart';
import 'package:turbokart/screens/payments/stripe/create_new_card_screen.dart';
import 'package:turbokart/screens/payments/stripe/credit_card_list.dart';
import 'package:turbokart/screens/payments/stripe/existing-cards.dart';
import 'package:turbokart/screens/payments/stripe/payment_home.dart';
import 'package:turbokart/screens/product_details_screen.dart';
import 'package:turbokart/screens/product_list_screen.dart';
import 'package:turbokart/screens/profile_screen.dart';
import 'package:turbokart/screens/profile_update_screen.dart';
import 'package:turbokart/screens/register_screen.dart';
import 'package:turbokart/screens/splash_screen.dart';
import 'package:turbokart/screens/vendors_home_screen.dart';
import 'package:turbokart/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Stripe key injected via --dart-define=STRIPE_KEY=...
  Stripe.publishableKey = const String.fromEnvironment('STRIPE_KEY');

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: String.fromEnvironment('FIREBASE_API_KEY'),
      authDomain: String.fromEnvironment('FIREBASE_AUTH_DOMAIN'),
      appId: String.fromEnvironment('FIREBASE_APP_ID'),
      messagingSenderId: String.fromEnvironment('FIREBASE_SENDER_ID'),
      projectId: String.fromEnvironment('FIREBASE_PROJECT_ID'),
      storageBucket: String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CouponsProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider()),
      ],
      child: const TurboKartApp(),
    ),
  );
}

class TurboKartApp extends StatelessWidget {
  const TurboKartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TurboKart',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: const SplashScreen(),
      // Keep all your existing routes here
    );
  }
}
