

import 'dart:io';

import 'package:ek/Auth/reset_password.dart';
import 'package:ek/Components/alerts.dart';
import 'package:ek/pages/set_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Components/Notify.dart';
import '../Components/style.dart';
import '../provider/local_storage/StoreCredentials.dart';
import '../security_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ///LOGOUT FUNCTION HERE
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Provider.of<LocalStorageProvider>(context, listen: false)
          .storeLoginStatus('false');
      Navigator.pushReplacementNamed(context, '/login');
      Notify(context, 'Logout Successful', Colors.green);
    } catch (e) {
      Notify(context, 'Error: $e', Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      Provider.of<LocalStorageProvider>(context, listen: false).getUsername();
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Title(
            color: Colors.black,
            child: Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Righteous',
                color: Colors.blueGrey,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [


                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                          children: [
                            FutureBuilder(
                              future: Provider.of<LocalStorageProvider>(
                                  context, listen: false).getProfilePicture(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircleAvatar(
                                    radius: 30,
                                    child: Icon(Icons.person, size: 30),
                                  );
                                } else if (snapshot.hasData) {
                                  return CircleAvatar(
                                    radius: 30,
                                    backgroundImage: FileImage(
                                        snapshot.data as File),
                                  );
                                }
                                return CircleAvatar(
                                  radius: 30,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/Icon/profile.png'),
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                );
                              },
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Column(
                                children: [
                                  FutureBuilder(
                                    future: Provider.of<LocalStorageProvider>(
                                        context, listen: false).getUsername(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text(
                                          'Username', style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),);
                                      } else if (snapshot.hasData) {
                                        return Text(snapshot.data.toString(),
                                          style: TextStyle(color: Colors.black,
                                              fontSize: 16.sp),);
                                      }
                                      return const Text('Username');
                                    },
                                  ),
                                  Text('House Father', style: TextStyle(
                                    fontFamily: 'QuickSand',
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                  ),),
                                ],
                              ),
                            ),
                          ]
                      )),

                  SizedBox(height: 20.h,),

                  ///Account Text Here
                  ///
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Account', textAlign: TextAlign.left,
                          style: moderateBoldTextStyle(Colors.black),),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),

                  ///CHANGE NAME
                  ///
                  ///
                  ///
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).showBottomSheet((context) {
                        return BottomSheet(dragHandleColor: Colors.black,
                            onClosing: () {},
                            builder: (BuildContext context) =>
                                Container(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          SizedBox(height: 10.h,),

                                          /// CHANGE NAME HERE
                                          ///
                                          RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Change',
                                                      style: TextStyle(
                                                        fontFamily: 'Righteous',
                                                        color: Colors.black,
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: 'Name',
                                                      style: TextStyle(
                                                        fontFamily: 'Righteous',
                                                        color: Colors.blueGrey,
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                      ),
                                                    ),
                                                  ]
                                              )
                                          ),

                                          /// change name here
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 50, 200, 10),
                                            child: Text('username',
                                              style: moderateBoldTextStyle(
                                                  Colors.black),
                                              textAlign: TextAlign.left,),
                                          ),

                                          /// TEXTFIELD FOR FULL NAME

                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 0, 16, 0),
                                            child: TextFormField(
                                              controller: userNameController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'This field can\'t be empty';
                                                }
                                                return null;
                                              },

                                              decoration: InputDecoration(
                                                label: Text('Full Name',
                                                  style: smallTextStyle(
                                                      Colors.black),),
                                                hintText: ' Mr. Kofi Mensah ',
                                                hintStyle: smallTextStyle(
                                                    Colors.black),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.black,
                                                      width: 1.0),
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.blueGrey,
                                                      width: 2.0),
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.h,),

                                          /// BUTTON FOR CONTINUE
                                          ElevatedButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate() == true &&
                                                  userNameController.text
                                                      .isNotEmpty) {
                                                Provider.of<
                                                    LocalStorageProvider>(
                                                    context, listen: false)
                                                    .storeUsername(
                                                    userNameController.text
                                                        .trim().toString());
                                                userNameController.clear();
                                                Notify(context,
                                                    'Username Sucessfully Changed',
                                                    Colors.green);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .blueGrey,
                                                padding: const EdgeInsets
                                                    .symmetric(horizontal: 120,
                                                    vertical: 20),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(30)
                                                )
                                            ),
                                            child: const Text(' Done',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight
                                                      .bold),),
                                          ),
                                          SizedBox(height: 10.h,),

                                          /// BUTTON FOR CANCEL EXEAT
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {

                                              });
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                padding: const EdgeInsets
                                                    .symmetric(horizontal: 120,
                                                    vertical: 20),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(30)
                                                )
                                            ),
                                            child: const Text(' Back ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight
                                                      .bold),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      },);
                    },
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 15.sp,
                                  child: Icon(Icons.person, size: 20.sp,),
                                ),
                                SizedBox(width: 10.w,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    children: [
                                      Text(' Change Name', style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold
                                      ),),

                                      FutureBuilder(
                                        future: Provider.of<
                                            LocalStorageProvider>(
                                            context, listen: false)
                                            .getUsername(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Text(
                                              'Username', style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),);
                                          } else if (snapshot.hasData) {
                                            return Text(
                                              snapshot.data.toString(),
                                              style: TextStyle(
                                                 fontFamily: 'QuickSand',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 12.sp),);
                                          }
                                          return const Text('Username');
                                        },
                                      ),


                                    ],
                                  ),
                                ),
                              ]
                          )),
                    ),
                  ),

                  SizedBox(height: 10.h,),

                  /// UPDATE PROFILE PICTURE
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => const SetProfile()));
                    },
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 15.sp,
                                  child: Icon(Icons.image, size: 20.sp,),
                                ),
                                SizedBox(width: 10.w,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text('Update Profile Picture',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      Text(Provider
                                          .of<LocalStorageProvider>(
                                          context, listen: false)
                                          .userName, style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'QuickSand',
                                        color: Colors.grey,
                                        fontSize: 12.sp,
                                      ),),
                                    ],
                                  ),
                                ),
                              ]
                          )),
                    ),
                  ),

                  SizedBox(height: 10.h,),

                  ///CHANGE PASSWPRD
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => const ResetPassword()));
                    },
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 15.sp,
                                  child: Icon(
                                    Icons.password_outlined, size: 20.sp,),
                                ),
                                SizedBox(width: 10.w,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    children: [
                                      Text(' Change Password', style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      Text('**********', style: TextStyle(
                                        fontFamily: 'QuickSand',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 4,
                                        color: Colors.grey,
                                        fontSize: 10.sp,
                                      ),),
                                    ],
                                  ),
                                ),
                              ]
                          )),
                    ),
                  ),
                  SizedBox(height: 10.h,),

                  SizedBox(height: 20.h,),

                  ///SECURITY Text Here
                  ///
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Security', textAlign: TextAlign.left,
                          style: moderateBoldTextStyle(Colors.black),),
                      ],
                    ),
                  ),

                  /// Upadte Security Here
                  ///

                  ///CHANGE SECURITY
                  ///
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => const SecurityInfo()));
                    },
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 20.sp,
                                  child: const ImageIcon(
                                    AssetImage('assets/Icon/guard.png'),
                                    size: 25, color: Colors.red,),
                                ),
                                SizedBox(width: 10.w,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text('Update Security Information',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      Text('Three security guards configured',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'QuickSand',
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                        ),),
                                    ],
                                  ),
                                ),
                              ]
                          )),
                    ),
                  ),
                  SizedBox(height: 30.h,),

                  /// DELETE ALL STUDENT DATA
                  ///
                  GestureDetector(
                    onTap: () {
                      alertDeleteAllStudent(context);
                    },
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 15.sp,
                                  child: Icon(Icons.document_scanner_outlined,
                                    size: 20.sp, color: Colors.red,),
                                ),
                                SizedBox(width: 10.w,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        'Clear students data', style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      Text('Entails all your stored students ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'QuickSand',
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                        ),),
                                    ],
                                  ),
                                ),
                              ]
                          )),
                    ),
                  ),
                  SizedBox(height: 10.h,),


                  /// DELETE ALL EXEATS
                  GestureDetector(
                    onTap: () {
                      alertDeleteAllexeat(context);
                    },
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 15.sp,
                                  child: Icon(
                                    Icons.approval_outlined, size: 20.sp,
                                    color: Colors.red,),
                                ),
                                SizedBox(width: 10.w,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text('Clear All Exeats', style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      Text('Entails all your stored Exeats ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'QuickSand',
                                          color: Colors.grey,
                                          fontSize: 10.sp,
                                        ),),
                                    ],
                                  ),
                                ),
                              ]
                          )),
                    ),
                  ),
                  SizedBox(height: 10.h,),


                  /// DELETE ALL SECURITY
                  GestureDetector(
                    onTap: () {
                      alertDeleteAllSecurity(context);
                    },
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 15.sp,
                                  child: Icon(
                                    Icons.security_outlined, size: 20.sp,
                                    color: Colors.red,),
                                ),
                                SizedBox(width: 10.w,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        'Clear All Security', style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      Text(' Entails all Securities ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'QuickSand',
                                          color: Colors.grey,
                                          fontSize: 10.sp,
                                        ),),
                                    ],
                                  ),
                                ),
                              ]
                          )),
                    ),
                  ),


                  SizedBox(height: 10.h,),

                  ///SIGNOUT
                  GestureDetector(
                    onTap: () {
                      signOut();
                    },
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(

                              children: [
                                CircleAvatar(
                                  radius: 15.sp,
                                  child: Icon(Icons.logout, size: 20.sp,
                                    color: Colors.red,),
                                ),
                                SizedBox(width: 10.w,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text('Logout', style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      Text(' Logout from the app ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'QuickSand',
                                          color: Colors.grey,
                                          fontSize: 10.sp,
                                        ),),
                                    ],
                                  ),
                                ),
                              ]
                          )),
                    ),
                  ),

                  ///VERSION HERE
                  SizedBox(height: 50.sp,),
                  Text('Version : 1.0.0',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'QuickSand',
                        color: Colors.grey,
                        fontSize: 10.sp),)
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

