// ignore_for_file: prefer_const_constructors

import 'package:ek/Auth/reset_password.dart';
import 'package:ek/Auth/signUp.dart';
import 'package:ek/Components/Notify.dart';
import 'package:ek/provider/local_storage/StoreCredentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Components/style.dart';
import '../pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  Future<void> signIn(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      //get uid
      final uid = _auth.currentUser!.uid;
      Provider.of<LocalStorageProvider>(context, listen: false).storeId(uid);

      Notify(context, 'Login Successful', Colors.green);
    } catch (e) {
      Notify(context, 'Error: $e', Colors.red);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }



final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final formkey = GlobalKey<FormState>();

@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100,),
            const ImageIcon(
              AssetImage('assets/images/ExeatKeeper.png'),
              size: 100,
              color: Colors.blueGrey,
            ),
              const SizedBox(height: 20),
              RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Exeat',
                          style: TextStyle(
                            fontFamily: 'Righteous',
                            color: Colors.black,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Keeper',
                          style: TextStyle(
                            fontFamily: 'Righteous',
                            color: Colors.blueGrey,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                  )
              ),
              const SizedBox(height: 20),
             const Text(' A better way to keep exeat', style: TextStyle(
               fontFamily: 'Trojan',
               color: Colors.black,
               fontSize: 15
             ),),
              const SizedBox(height: 20,),
              Container(
          height: 600,
                  decoration: BoxDecoration(

                      color: Colors.blueGrey,
                      // make the top borders
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)
                      )
                  ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            const SizedBox(height: 20,),
                            isLoading?CircularProgressIndicator(color: Colors.white,):Text('Login', style: boldTextStyle( Colors.white),),

                            ///EMAIL
                            ///
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                controller: _emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: '  Email',
                                  hintStyle: smallTextStyle(Colors.white),
                                  // Default border (shows when the TextField is enabled)
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 1.0,
                                          style: BorderStyle.solid
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(30))
                                  ),
                                  // Border when the TextField is focused
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2.0
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  // Optional: Border when the TextField has an error
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1.0
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  // Optional: Border when the TextField is disabled
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                ),
                              ),
                            ),

                            ///PASSWORD
                            ///
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                controller: _passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: '  Password',
                                  hintStyle: smallTextStyle(Colors.white),
                                  // Default border (shows when the TextField is enabled)
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 1.0,
                                          style: BorderStyle.solid
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(30))
                                  ),
                                  // Border when the TextField is focused
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2.0
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  // Optional: Border when the TextField has an error
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1.0
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  // Optional: Border when the TextField is disabled
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassword()));

                                    },
                                    child: const Text('Forgot your password ?',style: TextStyle(color: Colors.white),),
                                  )
                                ],
                              ),
                            ),
                            ///LOGIN BUTTON
                            ///
                            ElevatedButton(
                              onPressed: (){
                                if(formkey.currentState!.validate()){
                                  signIn(_emailController.text.trim(), _passwordController.text.trim()).then((_){
                                    Provider.of<LocalStorageProvider>(context, listen: false).storeLoginStatus('true');
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
                                    //clear controlers
                                    _emailController.clear();
                                    _passwordController.clear();
                                  });
                                }

                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  )
                              ),
                              child: const Text('Login', style: TextStyle(color: Colors.black),),
                            ),
                            SizedBox(height: 10,),

                            /// SIGN UP
                            ///
                            ///
                            ElevatedButton(
                              onPressed: (){
                                // print('ji');
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  )
                              ),
                              child: const Text('Sign Up', style: TextStyle(color: Colors.white),),
                            )



                          ],
                        ),
                      ),
                    ),
                  )
          ]

          ),
        ),
      ),
    );
  }}

