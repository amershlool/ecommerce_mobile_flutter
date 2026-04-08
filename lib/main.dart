import 'package:e_commerce/controller/notification_controller.dart';
import 'package:e_commerce/core/function/firebase/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:e_commerce/bindings/intialbinding.dart';
import 'package:e_commerce/core/localization/changelocal.dart';
import 'package:e_commerce/core/localization/translation.dart';
import 'core/constant/color.dart';
import 'core/serveces/services.dart';
import 'routes.dart';

@pragma('vm:entry-point')
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    FirebaseCrashlytics.instance.recordError(errorDetails, errorDetails.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await initFCM();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    firebaseMessagingListen(message);
  });
  Stripe.publishableKey = 'pk_test_51SJBupFe9XbrnuTGZw6XhdAdVxME28pwDzA4QDs2a03VLpylVOayL1vQhd4ruTJp3KxqQ6acyej1NZ5dfUZWRqJb00g6cfz926';
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final notificationController = Get.find<NotificationControllerImp>();
      notificationController.viewAllData();
    }
  }

  @override
  Widget build(BuildContext context) {
    LocalController localController = Get.put(LocalController());
    return
      GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: localController.language,
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            height: 2,
            color: AppColor.grey,
            fontFamily: 'BalooBhaijaan',
            fontSize: 18,
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 25,
            color: AppColor.darkGray,
            fontFamily: "Amiri",
          ),
          headlineLarge: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 50,
            color: Colors.black87,
            fontFamily: 'BalooBhaijaan',
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: InitialBindings(),
      getPages: routes,
    );
  }
}
