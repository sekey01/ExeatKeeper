import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/local_storage/StoreCredentials.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void>Loading() async {
    Provider.of<LocalStorageProvider>(context,listen: false).getId();
    await Future.delayed(Duration(seconds: 8));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   Provider.of<LocalStorageProvider>(context, listen: false).getLoginStatus(context);
    Loading();

  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Image(image: AssetImage('assets/images/ExeatKeeper.png')),
        ),))
    );
  }
}
