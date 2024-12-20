import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:ek/Components/Notify.dart';
import 'package:ek/Components/alerts.dart';
import 'package:ek/Models/student_datail_model.dart';
import 'package:ek/pages/search_student_page.dart';
import 'package:ek/provider/local_storage/StoreCredentials.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../Components/searchbarIcon.dart';
import '../Components/simple row.dart';
import '../Components/style.dart';
import '../Models/sign_exeat_model.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  TextEditingController searchitemController = TextEditingController();


  final formKey = GlobalKey<FormState>();
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _studentLocationController = TextEditingController();
  final TextEditingController _studentRoomController = TextEditingController();
  final TextEditingController _parentTellController = TextEditingController();
final TextEditingController _classRoomController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Title(color: Colors.black, child: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'House',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        color: Colors.black,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Students',
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
          ),
        ),
      body: SingleChildScrollView(
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const StudentSearch()));
        },
                  child: SearchBarIcon()),





              FutureBuilder<List<StudentDetailModel>>(
                future: Provider.of<LocalStorageProvider>(context, listen: true).loadStudents(),
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
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: double.infinity,
                              height: 400.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.transparent,
                              ),
                              child: const Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(image: AssetImage('assets/images/no_data.png'), height: 200, width: 200,),
                                    Text(
                                      'No student data recorded !',
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ),
                    );
                  }

                  return Container(
                    color: Colors.grey.shade200,
                    height: 800.h,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final student = snapshot.data![index];
                        final studentNumber = index + 1; // Using index + 1 for student number

                        return InkWell(
                          onLongPress: () {
                            alertDeleteStudent(context, studentNumber-1);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTile(
                              collapsedShape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
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
                                  fontFamily: 'QuickSand',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15.spMin,
                                ),
                              ),
                              leading: const CircleAvatar(child: Icon(Icons.school_outlined, color: Colors.black,)),
                              children: [
                                StudentDetailRow(label: 'Name', value: student.name),
                                StudentDetailRow(label: 'Class', value: student.classRoom),
                                StudentDetailRow(label: 'Location', value: student.location.toString()),
                                StudentDetailRow(label: 'Room Number', value: student.roomNumber.toString()),
                                InkWell(
                                  onTap: () async{
                                    EasyLauncher.call(number: student.parentTell.toString());
                                  },
                                  child: Badge(
                                    textStyle: TextStyle(color: Colors.white, fontSize: 8.spMin,fontFamily: 'QuickSand',fontWeight: FontWeight.bold),
                                    alignment: Alignment.topCenter,
                                    backgroundColor: Colors.blueGrey,
                                    label: Text('Tap to call Guardian', style: TextStyle(color: Colors.white, fontSize: 8.spMin),),
                                      child: StudentDetailRow(label: 'Parent Tell', value: student.parentTell.toString())),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
        floatingActionButton: GestureDetector(
          onTap: (){
            Scaffold.of(context).showBottomSheet((context) {
              return BottomSheet(dragHandleColor: Colors.black,onClosing: (){}, builder:(BuildContext context)=> Container(
                child: SingleChildScrollView(
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
                                      text: 'Student',
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





                          /// Student name
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 50,200, 10),
                            child: Text('Student name:', style: moderateBoldTextStyle(Colors.black),textAlign: TextAlign.left,),
                          ),

                          /// TEXTFIELD FOR STUDENT FULL NAME

                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: TextFormField(
                              validator: (value){
                                if( value!.isEmpty){
                                  return " enter name here";
                                }
                                return null;
                              },
                              controller: _studentNameController,
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




                          /// Student Location
                          ///
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 30,200, 10),
                            child: Text('location:', style: moderateBoldTextStyle(Colors.black),textAlign: TextAlign.left,),
                          ),
                          /// TEXTFIELD FOR STUDENT lOCATION
                          ///
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: TextFormField(
                              controller: _studentLocationController,
                              decoration: InputDecoration(
                                label: Text('Location Of Student', style: smallTextStyle(Colors.black),),
                                hintText: 'Location Of Student ',
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






                          /// Student Room
                          ///
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 30,200, 10),
                            child: Text('Room Number:', style: moderateBoldTextStyle(Colors.black),textAlign: TextAlign.left,),
                          ),
                          /// TEXTFIELD FOR STUDENT ROOM NUMBER
                          ///
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: TextFormField(
                              controller: _studentRoomController,
                              decoration: InputDecoration(
                                label: Text('Student Room', style: smallTextStyle(Colors.black),),
                                hintText: 'Student Room Number ',
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








                          ///Parent Tell
                          ///
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 30,200, 10),
                            child: Text('Parent Tell:', style: moderateBoldTextStyle(Colors.black),textAlign: TextAlign.left,),
                          ),
                          /// TEXTFIELD FOR PARENT TELL
                          ///
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: TextFormField(
                              controller: _parentTellController,
                              decoration: InputDecoration(
                                label: Text('Parent Tell', style: smallTextStyle(Colors.black),),
                                hintText: ' Parent Tell ',
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




                          ///Class Room
                          ///
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 30,200, 10),
                            child: Text('Class Room:', style: moderateBoldTextStyle(Colors.black),textAlign: TextAlign.left,),
                          ),
                          /// TEXTFIELD FOR CLASS ROOM
                          ///
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: TextFormField(
                              controller: _classRoomController,
                              decoration: InputDecoration(
                                label: Text('Class Room', style: smallTextStyle(Colors.black),),
                                hintText: ' Class Room ',
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
                          SizedBox(height: 10.h,),







                          /// BUTTON FOR ADD
                          ///
                          ElevatedButton(
    onPressed: (){
    Provider.of<LocalStorageProvider>(context, listen: false).addStudent(

    StudentDetailModel(
                     name: _studentNameController.text,
                     location: _studentLocationController.text,
                      roomNumber: _studentRoomController.text,
                      parentTell: _parentTellController.text,
                      classRoom: _classRoomController.text
                            )

    ).then((_){
   setState(() {
     _classRoomController.clear();
     _studentNameController.clear();
     _studentLocationController.clear();
     _studentRoomController.clear();
   });
   Notify(context, 'Done', Colors.green);
   Navigator.pop(context);



    });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)
                                )
                            ),
                            child: const Text(' Add +', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: 10.h,),





                          /// BUTTON FOR CANCEL EXEAT
                          ///
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
                child: Text('Add Student +', style: TextStyle(color: Colors.white,fontSize: 10.sp,fontFamily: 'QuickSand',fontWeight: FontWeight.bold),),
              ),
            ),
          ),
        )
    );
  }

}








