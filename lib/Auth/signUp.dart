import 'package:ek/Auth/select_school.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Components/Notify.dart';
import '../Components/style.dart';
import '../provider/local_storage/StoreCredentials.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  Future<void> signUp(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,);
     setState(() {
      Uid = userCredential.user!.uid;
     });
          // Notify user of successful sign-up
          Notify(context, 'Sign Up Successful', Colors.green);

    } catch (e) {
      // Handle errors
      Notify(context, 'Error: $e', Colors.red);
    }
  }



  bool isLoading = false;
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  String Uid = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20.h,),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    'assets/images/signUp.svg',
                    // Optional parameters
                    width: 200,  // Set width if needed
                    height: 100, // Set height if needed
                  ),
                ),

                ///Sign Up Text
                Text('Sign Up', style: boldTextStyle(Colors.white),),
                Text('Join us today and worry less', style: smallTextStyle(Colors.white),),
                Text(' about exeats', style: smallTextStyle(Colors.white),),
                SizedBox(height: 30.h,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: TextFormField(
                            validator: (value){
                              if(value!.isEmpty){
                                return 'First Name is required';
                              }
                              return null;
                            },
                            controller: firstNameController,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              hintStyle: smallTextStyle(Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Last Name is required';
                              }
                              return null;
                            },
                            controller: lastNameController,
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              hintStyle: smallTextStyle(Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.sp,),
            /// EMAIL TEXTFIELD
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Email is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'email',
                      hintStyle: smallTextStyle(Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.sp,),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    validator:  (value){
                      if(value!.isEmpty){
                        return 'Password is required';
                      }
                      return null;
                    },
                    controller: passwordController,
obscureText: true,                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: smallTextStyle(Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.sp,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Password is required';
                      }
                      return null;

                    },
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: smallTextStyle(Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                  SizedBox(height: 20.sp,),
                  Container(
                    height: 300.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Colors.white, Colors.blue.shade50,]),
                                color: Colors.white,

                                borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.r),
                                topRight: Radius.circular(50.r)
                              )
                            ),

                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 50.h,),
                                  isLoading? const CircularProgressIndicator(color: Colors.black,):ElevatedButton(
                                              onPressed: (){
                                                // Validate the form
                                                if (formkey.currentState?.validate() == true && passwordController.text == confirmPasswordController.text) {
                                                  Provider.of<LocalStorageProvider>(context, listen: false).storeUsername('${firstNameController.text} ${lastNameController.text}');
                                                  signUp(context,emailController.text.toString(), passwordController.text.toString()).then((_){
                                                    Provider.of<LocalStorageProvider>(context, listen: false).storeId(Uid);
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectSchool(Uid:Uid ,)));
                                                  });

                                                } else {
                                                  Notify(context, 'Passwords Dont match', Colors.red);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blueGrey,
                                                  padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(30)
                                                  )
                                              ),
                                              child: const Text('Continue', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(height: 20.h,),
                                  ///Already have an account?
                                  Text('Already a member ?', style: smallTextStyle(Colors.black),),
                                  ElevatedButton(
                                              onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(30)
                                                  )
                                              ),
                                              child:  const Text(' Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(height: 30.sp,),
                                  Text('By continuing,you agree to our Terms Of Use and Privacy Policy', style: TextStyle(fontSize: 10.sp,color: Colors.black),)
                                ],
                              ),
                            ),
                  )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
