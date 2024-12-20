import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Components/Notify.dart';
import '../Components/style.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}
final formKey = GlobalKey<FormState>();
class _ResetPasswordState extends State<ResetPassword> {

//Password Reset Functionality
  Future<void> sendPasswordResetEmail( String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Notify(context, 'Password reset email sent', Colors.green);
    } catch (e) {
      Notify(context, 'Error: $e', Colors.red);
    }
  }
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(image: const AssetImage('assets/Icon/reset_password.png'), height: 100.h,width: 150.w,),
              ),
              const SizedBox(height: 30),


              const Text('A password reset link will be sent to your email', style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: 'QuickSand'), textAlign: TextAlign.center,),
              const SizedBox(height: 20),
              ///EMAIL
              ///
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  controller: _emailController,
                  style: const TextStyle(color: Colors.blueGrey),
                  decoration: InputDecoration(
                    hintText: ' Enter your email',
                    hintStyle: smallTextStyle(Colors.black),
                    // Default border (shows when the TextField is enabled)
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                            style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    // Border when the TextField is focused
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    // Optional: Border when the TextField has an error
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 1.0
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    // Optional: Border when the TextField is disabled
                    disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                ),
              ),


              SizedBox(height: 30.h,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
               backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    sendPasswordResetEmail(_emailController.text.toString()).then(
                            (value) {
                               Future.delayed(const Duration(seconds: 2));
                              Navigator.pushReplacementNamed(context, '/login');
                            }
                    );
                  }
                 // Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Reset Password', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
