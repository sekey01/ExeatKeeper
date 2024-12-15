
import 'package:ek/Notification_Provider/notification_provider.dart';
import 'package:ek/pages/home.dart';
import 'package:ek/pages/init_pages/splash_screen.dart';
import 'package:ek/provider/functions/download_function.dart';
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
   await dotenv.load(fileName: "assets/.env");
  // Ensure that widget binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

    await Supabase.initialize(
        url: 'https://oehkjbrqffbwwbmrdhpr.supabase.co',
        anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9laGtqYnJxZmZid3dibXJkaHByIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg5OTEyOTgsImV4cCI6MjA0NDU2NzI5OH0.oRDO1gwo6Jwv_q7Li2vuzY2LPnU7dr0IgjxQ6XhDF_k'
    );

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
          ChangeNotifierProvider(create: (context) => LocalStorageProvider()),
          ChangeNotifierProvider(create: (context) => NotificationProvider()),
          ChangeNotifierProvider(create: (context) => DownloadFunction()),

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
