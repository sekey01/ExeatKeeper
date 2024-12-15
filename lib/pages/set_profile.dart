import 'dart:io';

import 'package:ek/provider/local_storage/StoreCredentials.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Components/Notify.dart';

class SetProfile extends StatefulWidget {
  const SetProfile({super.key});

  @override
  State<SetProfile> createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  File? _profileImage;

  ///PROFILE IMAGE PICKER  HERE
  Future<void> _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 150.h,),
                /// CHANGE IMAGE HERE
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Image',
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
                /// change iMAGE here
          SizedBox(height: 40.h,),
                GestureDetector(
                  onTap: () {
                    _pickProfileImage();

                  },
                  child: Badge(
                    label: const Text('Select  Image'),
                    textStyle: const TextStyle(letterSpacing: 3, fontSize: 10),
                    alignment: Alignment.topLeft,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: _profileImage != null
                            ? Image.file(
                          height: 190,
                          width: 190,
                          _profileImage!,
                          fit: BoxFit.fill,
                        )
                            : Image(
                          image: const AssetImage('assets/Icon/selectImage.png'),
                          height: 150.h,
                          width: 150.h,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h,),

                /// BUTTON FOR CONTINUE
                ElevatedButton(
                  onPressed: (){
                    if(_profileImage != null){
                      Provider.of<LocalStorageProvider>(context, listen: false).saveProfilePicture(_profileImage!).then((_){
                        setState(() {
                          _profileImage = null;
                        });
                      });

                    //  Navigator.pop(context);
                      Notify(context, 'Profile Picture Sucessfully Changed', Colors.green);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  ),
                  child: const Text(' Done', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
