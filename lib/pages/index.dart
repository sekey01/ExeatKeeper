import 'package:ek/Components/alerts.dart';
import 'package:ek/Components/cards.dart';
import 'package:ek/Components/simple%20row.dart';
import 'package:ek/Models/school_details_model.dart';
import 'package:ek/Models/sign_exeat_model.dart';
import 'package:ek/Notification_Provider/notification_provider.dart';
import 'package:ek/provider/functions/uploadfunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Components/style.dart';
import '../provider/local_storage/StoreCredentials.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {

  ///  FUNCTION TO CALL A SCHOOL DETAILS with ID THAT MATCHES WITH  ID Value FROM SUPABASE DATABASE TABLE 'HouseFather' in the column 'schooldetails' of datatype json

  Future<void> getHouseFatherDetails() async {
    final supabase = Supabase.instance.client;

    try {
      final List<Map<String, dynamic>> data =
      await supabase.from('cities').insert([
        {'name': 'The Shire', 'country_id': 554},
        {'name': 'Rohan', 'country_id': 555},
      ]).select();


    } catch (e) {
      print('An error occurred: $e');
    }
  }

  final formKey = GlobalKey<FormState>();
final TextEditingController _nameController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _parentTellController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LocalStorageProvider>(context,listen: false).getId();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
automaticallyImplyLeading: false,
        title: Title(color: Colors.black, child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Exeat',
                style: TextStyle(
                  fontFamily: 'Righteous',
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Keeper',
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
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// INIT CONTAINER
            ///

            Builder(
              builder: (context) {
                Provider.of<LocalStorageProvider>(context,listen: false).getId();
                return FutureBuilder(
                  future: Provider.of<UploadFunctionProvider>(context, listen: false).getMySchool(Provider.of<LocalStorageProvider>(context,listen: false).id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome 👋',
                            style: TextStyle(color: Colors.blue, fontSize: 14.sp),
                          ),
                          // Icon button to refresh the page
                          IconButton(
                            icon: const Icon(Icons.refresh, color: Colors.blueGrey,),
                            onPressed: () {
                              setState(() {});
                            },
                          ),


                        ],
                      );
                    } else if (snapshot.hasData) {
                      final schoolDetails = snapshot.data as SchoolDetailsModel;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InitContainer(
                          schoolDetails.schoolName,
                          schoolDetails.houseName,
                          schoolDetails.house,
                        ),
                      );
                    } else {
                      return const Text('No school details available');
                    }
                  },
                );
              }
            ),



            /// RECENT EXEATS
            ///
            ///
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Recent Exeats', textAlign: TextAlign.left, style: moderateBoldTextStyle(Colors.black),),
                ],
              ),
            ),
/// RECENT EXEATS HERE
            ///
            ///
            ///
            FutureBuilder<List<SignExeatModel>>(
              future: Provider.of<LocalStorageProvider>(context, listen: true).loadExeats(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 50),
                        Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.red, fontSize: 15.spMin),
                        ),
                      ],
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: double.infinity,
                        height: 600.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade300,
                        ),
                        child: const Expanded(
                          flex: 1,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage('assets/images/no_data.png'), height: 200, width: 200,),
                                Text(
                                  'No Exeat recorded',
                                  style: TextStyle(color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return Container(
                  color: Colors.transparent,
                  height: 500.h,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final student = snapshot.data![index];
                      final studentNumber = index + 1; // Using index + 1 for student number

                      return InkWell(
                        onDoubleTap: (){
                          Provider.of<LocalStorageProvider>(context, listen: false).updateIsBackStatus(index, !student.isBack);
                        },
                        onLongPress: () {
                          alertDeleteExeat(context, studentNumber-1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Badge(
                            alignment: Alignment.topCenter,
                            label: Text(student.isBack ? 'Signed In' : 'Signed Out', style: TextStyle(color: Colors.white, fontSize: 10.spMin),),
                            backgroundColor: student.isBack ? Colors.green : Colors.red,
                            child: ExpansionTile(
                              collapsedShape: RoundedRectangleBorder(
                                side: const BorderSide( width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              iconColor: Colors.black,
                              collapsedBackgroundColor: Colors.grey.shade300,

                              title: Text(
                                ' ${student.name}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.spMin,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              leading: const CircleAvatar(child:
                      ImageIcon(AssetImage('assets/Icon/student.png'), size: 25, color: Colors.black,),),
                              backgroundColor: Colors.white,
                              children: [
                                StudentDetailRow(label: 'Name', value: student.name),
                                StudentDetailRow(label: 'To', value: student.to),
                                StudentDetailRow(label: 'Reason', value: student.reason),
                                StudentDetailRow(label: 'Departure', value: student.time),
                              ],

                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),


            ]
        ),
      ),

      floatingActionButton: GestureDetector(
        onTap: (){
          Scaffold.of(context).showBottomSheet((context) {
            return BottomSheet(dragHandleColor: Colors.black,onClosing: (){}, builder:(BuildContext context)=> SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 50.h,),
                      /// NEW EXEAT HERE
                      ///
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'New ',
                                  style: TextStyle(
                                    fontFamily: 'Righteous',
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Exeat',
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
                                  /// Student
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 50,200, 10),
                        child: Text('Student:', style: moderateBoldTextStyle(Colors.black),textAlign: TextAlign.left,),
                      ),

                      /// TEXTFIELD FOR STUDENT FULL NAME

                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: TextFormField(
                          controller: _nameController,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Please enter student name';
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                            label: Text('Student Full Name', style: smallTextStyle(Colors.black),),
                            hintText: 'Student Full Name ',
                            hintStyle: smallTextStyle(Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30,200, 10),
                        child: Text(' Student to :', style: moderateBoldTextStyle(Colors.black),textAlign: TextAlign.left,),
                      ),
                      /// TEXTFIELD FOR STUDENT lOCATION\
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: TextFormField(
                          controller: _toController,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Please enter where student is going';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text('To', style: smallTextStyle(Colors.black),),
                            hintText: 'To ',
                            hintStyle: smallTextStyle(Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),

                      ///TEXTFIELD FOR PARENT CONTACT
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30,200, 10),
                        child: Text('Parent Tel:', style: moderateBoldTextStyle(Colors.black),textAlign: TextAlign.left,),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: _parentTellController,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Please enter parent contact';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text('Parent Contact', style: smallTextStyle(Colors.black),),
                            hintText: ' Parent Contact',
                            hintStyle: smallTextStyle(Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),

                      ///Description
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30,200, 10),
                        child: Text('Description:', style: moderateBoldTextStyle(Colors.black),textAlign: TextAlign.left,),
                      ),
                      /// TEXTFIELD FOR REASON
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: TextFormField(
                          controller: _reasonController,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Please enter reason for exeat';
                            }
                            return null;
                          },
                          maxLines: 5,
                          decoration: InputDecoration(
                            label: Text('Reason', style: smallTextStyle(Colors.black),),
                            hintText: ' Reason  for Exeat',
                            hintStyle: smallTextStyle(Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),


                      /// BUTTON FOR CONTINUE
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Provider.of<LocalStorageProvider>(context, listen: false).addExeat(
                              SignExeatModel(
                                name: _nameController.text,
                                to: _toController.text,
                                reason: _reasonController.text,
                                time: DateTime.now().toString(),
                                isBack: false,
                              ),
                            ).then((_) {
                              Provider.of<NotificationProvider>(context,listen:false).sendSms(_parentTellController.text,
                                  'Your child ${_nameController.text} has been signed out of school to ${_toController.text} for the reason: ${_reasonController.text}').then((_) {
                                  _nameController.clear();
                                  _toController.clear();
                                  _reasonController.clear();
                                  _parentTellController.clear();
                              });

                              Navigator.pop(context);
                            });
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
                      SizedBox(height: 10.h,),
                      /// BUTTON FOR CANCEL EXEAT
                      ElevatedButton(
                        onPressed: (){
                  Navigator.pop(context);                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                        ),
                        child: const Text(' Cancel', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
              ),
            ));
          },);
        },
        child: Container(
        
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Colors.black, Colors.blueGrey]),
            borderRadius: BorderRadius.circular(30),
            color: Colors.blueGrey,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('Approve Exeat +', style: TextStyle(color: Colors.white,fontSize: 8.sp),),
            ),
          ),
        ),
      )
    );
  }
}



