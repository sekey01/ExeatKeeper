
import 'package:ek/Notification_Provider/notification_provider.dart';
import 'package:ek/pages/home.dart';
import 'package:ek/pages/init_pages/splash_screen.dart';
import 'package:ek/provider/functions/download_function.dart';
import 'package:ek/provider/functions/other_functions.dart';
import 'package:ek/provider/functions/uploadfunction.dart';
import 'package:ek/provider/local_storage/StoreCredentials.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Auth/login.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   await dotenv.load(fileName: "assets/.env");
  // Ensure that widget binding is initialized
  WidgetsFlutterBinding.ensureInitialized();



        // Run the app
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => KeyFunctions()),
          ChangeNotifierProvider(create: (context) => LocalStorageProvider()),
          ChangeNotifierProvider(create: (context) => NotificationProvider()),
          ChangeNotifierProvider(create: (context) => DownloadFunction()),
          ChangeNotifierProvider(create: (context) => UploadFunctionProvider()),

        ],
        child: MaterialApp(
          routes: {
            '/login': (context) => const Login(),
            '/home': (context) => const Home(),
            '/splash_screen': (context) => const SplashScreen(),
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Righteous',

          ),
          home: const SplashScreen(),
        ),
      ),

    );
  }
}
