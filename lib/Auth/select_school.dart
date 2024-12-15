
import 'package:ek/Models/school_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Components/Notify.dart';
import '../Components/style.dart';
import '../provider/functions/uploadfunction.dart';
import '../provider/local_storage/StoreCredentials.dart';
import 'add_security.dart';

class SelectSchool extends StatefulWidget {
  const SelectSchool({super.key});


  @override
  State<SelectSchool> createState() => _SelectSchoolState();

}

class _SelectSchoolState extends State<SelectSchool> {
 final formkey = GlobalKey<FormState>();
   late String school;
  late String houseNumber;
  final TextEditingController houseNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Provider.of<LocalStorageProvider>(context,listen: false).getId();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.h,),
              Text('Select School', style: boldTextStyle(Colors.black),),
              const Text('Join us today and worry less about exeats'),
              Image(image: const AssetImage('assets/images/High_School.png'), height: 250.h,width: 250.w,),
              Container(
                width: double.infinity,
                height: 350.h,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Expanded(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                    ///DROPDOWN BUTTON FOR SCHOOL
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: DropdownButtonFormField(
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please select school';
                                }
                                return null;
                              },
                            icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.white,),
                              decoration: InputDecoration(
                                label: Text('Select School', style: smallTextStyle(Colors.white),),
                                hintText: 'Select School',
                                hintStyle: smallTextStyle(Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'Mawuli School',child: Text('Mawuli School'),),
                                DropdownMenuItem(value: 'Agortime Senior High',child: Text(' Agortime Senior High'),),
                                DropdownMenuItem(value: 'Wesley Girls',child: Text('Wesley Girls'),),
                                DropdownMenuItem(value: 'Prempeh College',child: Text('Prempeh College'),),
                                DropdownMenuItem(value: 'Adisadel College',child: Text('Adisadel College'),),
                                DropdownMenuItem(value: 'Achimota School',child: Text('Achimota School'),),
                                DropdownMenuItem(value: 'Mfantsipim School',child: Text('Mfantsipim School'),),
                                DropdownMenuItem(value: 'Opoku Ware School',child: Text('Opoku Ware School'),),
                                DropdownMenuItem(value: 'Pope Johns',child: Text('Pope Johns'),),
                                DropdownMenuItem(value: 'Pope Paul',child: Text('Pope Paul'),),
                                DropdownMenuItem(value: 'Pope Peter',child: Text('Pope Peter'),),
                                DropdownMenuItem(value: 'Pope Francis',child: Text('Pope Francis'),),
                                DropdownMenuItem(value: 'Pope Benedict',child: Text('Pope Benedict'),),
                                DropdownMenuItem(value: 'Pope Pius',child: Text('Pope Pius'),),
                                DropdownMenuItem(value: 'Adisadel College',child: Text('Adisadel College'),),
                                DropdownMenuItem(value: 'St. Marys',child: Text('St. Marys'),),
                                DropdownMenuItem(value: 'St. Peters',child: Text('St. Peters'),),
                                DropdownMenuItem(value: 'St. Roses',child: Text('St. Roses'),),
                                DropdownMenuItem(value: 'St. Thomas Aquinas',child: Text('St. Thomas Aquinas'),),
                                DropdownMenuItem(value: 'St. Johns',child: Text('St. Johns'),),
                                DropdownMenuItem(value: 'St. Augustines',child: Text('St. Augustines'),),
                                DropdownMenuItem(value: 'St. Louis',child: Text('St. Louis'),),
                                DropdownMenuItem(value: 'St. Francis',child: Text('St. Francis'),),
                                DropdownMenuItem(value: 'St. Charles',child: Text('St. Charles'),),
                                DropdownMenuItem(value: 'St. Pauls',child: Text('St. Pauls'),),
                                DropdownMenuItem(value: 'St. Josephs',child: Text('St. Josephs'),),
                                DropdownMenuItem(value: 'St. Ignatius',child: Text('St. Ignatius'),),
                                DropdownMenuItem(value: 'St. Monicas',child: Text('St. Monicas'),),
                                DropdownMenuItem(value: 'St. Theresas',child: Text('St. Theresas'),),
                                DropdownMenuItem(value: 'St. Martins',child: Text('St. Martins'),),
                                DropdownMenuItem(value: 'St. Annes',child: Text('St. Annes'),),
                                DropdownMenuItem(value: 'St. Andrews',child: Text('St. Andrews'),),
                                DropdownMenuItem(value: 'St. Catherines',child: Text('St. Catherines'),),



                              ],
                              onChanged: (value){
                              setState(() {
                                school = value.toString();
                              });
                              }),
                        ),

                        ///DROPDOWN BUTTON FOR HOUSE
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: DropdownButtonFormField(
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please select house';
                                }
                                return null;
                              },
                              icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.white,),

                              decoration: InputDecoration(
                                label: Text('Select House', style: smallTextStyle(Colors.white),),
                                hintText: 'Select House',
                                hintStyle: smallTextStyle(Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(value: '1',child: Text('House 1'),),
                                DropdownMenuItem(value: '2',child: Text('House 2'),),
                                DropdownMenuItem(value: '3',child: Text('House 3'),),
                                DropdownMenuItem(value: '4',child: Text('House 4'),),

                              ],
                              onChanged: (value){
                                setState(() {
                                  houseNumber = value.toString();
                                });
                              }),
                        ),
                        ///TEXTFIELD TO ENTER HOUSE NAME
                        ///
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: TextFormField(
                            controller: houseNameController,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: Text('House Name', style: smallTextStyle(Colors.white),),
                              hintText: ' House Name',
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

                        //Elevated button
                        SizedBox(height: 40.h,),
                        ElevatedButton(
                          onPressed: (){
    if(formkey.currentState!.validate()){
  Provider.of<LocalStorageProvider>(context, listen: false).addSchoolDetail(SchoolDetailsModel(schoolName:school , house: houseNumber, houseName: houseNameController.text));
  Notify(context, 'School Selected Successfully', Colors.green);

    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SelectSecurity()));

    }

    },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              )
                          ),
                          child: const Text('Continue', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),
                )

              )

            ],
          ),
        ),
      ),
    );
  }
}
