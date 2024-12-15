

import 'package:ek/provider/local_storage/StoreCredentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../Components/Notify.dart';
import '../Components/style.dart';
import '../Models/security_data_model.dart';
import '../pages/home.dart';

class SelectSecurity extends StatefulWidget {
  const SelectSecurity({super.key});

  @override
  State<SelectSecurity> createState() => _SelectSecurityState();
}
final formKey = GlobalKey<FormState>();
final TextEditingController securityNameController = TextEditingController();
final TextEditingController securityPhoneNumberController = TextEditingController();


class _SelectSecurityState extends State<SelectSecurity> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key:  formKey,
            child: Column(
              children: [
                Container(
                  height: 450.h,
                  decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    // make the top borders
                    borderRadius: BorderRadius.only(
                     bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)
                    )
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            'assets/images/Security_Pana.svg',
                            // Optional parameters
                            width: 150,  // Set width if needed
                            height: 150, // Set height if needed
                          ),
                        ),
                        Text('Security', style: boldTextStyle(Colors.white),),
                        Text('We take security to a new level', style: smallTextStyle(Colors.white),textAlign: TextAlign.center,),
                        SizedBox(height: 20.h,),

                        ///FIRST SECURITY
                        Text('First Security', style: smallTextStyle(Colors.white),textAlign: TextAlign.left,),
                        SizedBox(height: 5.h,),

                        ///SECURITY NAME
                        ///
                        ///
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: TextFormField(
                            controller: securityNameController,
                             validator: (value){
                              if(value!.isEmpty){
                                return 'Nmae required';
                              }
                              return null;
                             },
                            decoration: InputDecoration(
                              label: Text('Full Name', style: smallTextStyle(Colors.white),),
                              hintText: 'First Security',
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
                        SizedBox(height: 20.h,),

                        ///SECURITY PHONENUMBER
                        ///
                        ///
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: TextFormField(
                            controller: securityPhoneNumberController,
                            validator:(value){
                              if (value!.isEmpty){
                                return 'Number required';
                              }
                              return null;
                            } ,
                            decoration: InputDecoration(
                              label: Text('Phone Number', style: smallTextStyle(Colors.white),),
                              hintText: 'First Security',
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
                        SizedBox(height: 20.h,),


                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Text('You can add more security later in settings', textAlign: TextAlign.center,style: smallTextStyle(Colors.black),),
                SizedBox(height: 30.h,),

                ElevatedButton(
                  onPressed: (){
                    if(formKey.currentState?.validate() ==true){
                      Provider.of<LocalStorageProvider>(context,listen: false).addSecurityDetail(
                          SecurityDetailsModel(
                              securityName: securityNameController.text,
                            securityPhone: securityPhoneNumberController.text
                      ));

                      Notify(context, 'Security added Successfully', Colors.green);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Home()));

                    }

                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  ),
                  child: const Text(' Continue', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
