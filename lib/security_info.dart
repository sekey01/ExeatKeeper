import 'package:ek/Components/alerts.dart';
import 'package:ek/provider/local_storage/StoreCredentials.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'Components/security_row.dart';
import 'Components/style.dart';
import 'Models/security_data_model.dart';

class SecurityInfo extends StatefulWidget {
  const SecurityInfo({super.key});

  @override
  State<SecurityInfo> createState() => _SecurityInfoState();
}

class _SecurityInfoState extends State<SecurityInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _securityNameController = TextEditingController();
  final TextEditingController _securityPhoneController = TextEditingController();

  @override
  void dispose() {
    _securityNameController.dispose();
    _securityPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Colors.black,
          child: Text(
            'Security Information',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10.h,),

            FutureBuilder<List<SecurityDetailsModel>>(
              future: Provider.of<LocalStorageProvider>(context, listen: false)
                  .loadSecurityDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Center(child: Text(
                      'No security details found.', style: TextStyle(
                        color: Colors.red),)),
                  );
                } else {
                  final securityDetails = snapshot.data!;
                  return Container(
                    height: 700.h,
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: securityDetails.length,
                      itemBuilder: (context, index) {
                        final security = securityDetails[index];
                        return InkWell(
                            onLongPress: (){
                              alertDeleteSecurity(context, index);
                              setState(() {

                              });
                            },
                            child: securityRow(security.securityName, security.securityPhone, index));
                      },
                    ),
                  );
                }
              },
            ),

          ],
        ),
      ),

      bottomSheet: BottomSheet(
        onClosing: () {

        },
        showDragHandle: true,
        enableDrag: true,
        builder: (context) {
          return Container(
            height: 220.h,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(20.r)
            ),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
              
                    RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Add ',
                                style: TextStyle(
                                  fontFamily: 'Righteous',
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'Security',
                                style: TextStyle(
                                  fontFamily: 'Righteous',
                                  color: Colors.blueGrey,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]
                        )
                    ),
                    SizedBox(height: 10.h,),
              
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: TextFormField(
                        controller: _securityNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a security name';
                          }
                          return null;
                        },
              
                        decoration: InputDecoration(
                          label: Text('Security Full Name', style: smallTextStyle(
                              Colors.black),),
                          hintText: 'Security Full Name ',
                          hintStyle: smallTextStyle(Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 2.0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: TextFormField(
                        controller: _securityPhoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a security Telephone';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
              
                        decoration: InputDecoration(
                          label: Text('Security Tell', style: smallTextStyle(
                              Colors.black),),
                          hintText: 'Security Tell ',
                          hintStyle: smallTextStyle(Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 2.0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
              
                    /// BUTTON FOR CONTINUE
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<LocalStorageProvider>(context, listen: false)
                            .addSecurityDetail(
                            SecurityDetailsModel(securityName: _securityNameController.text, securityPhone: _securityPhoneController.text)
                        );

                        setState(() {
Navigator.pop(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),
                      child: const Text(' Done', style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
            ),
          );
        },),

    );
  }
}
