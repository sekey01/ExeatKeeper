import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek/Models/school_details_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Models/security_data_model.dart';

class UploadFunctionProvider extends ChangeNotifier{
  Future<void> UploadSchoolDetail(SchoolDetailsModel details) async {
    try {
      await FirebaseFirestore.instance.collection('SchoolDetails').doc(details.userId).set(details.toJson());
    } catch (e) {
      print(e);
    }
  }

Future<SchoolDetailsModel> getMySchool(userId) async{
  try {
    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('SchoolDetails').doc(userId).get();
    if (documentSnapshot.exists) {
      final data = documentSnapshot.data() as Map<String, dynamic>;
      return SchoolDetailsModel.fromJson(data);
    }

  } catch (e) {
    print(e);
  } throw 'Error';
}

/*  Future<void> UploadSecurityData(SecurityDetailsModel securityData, String userId )async {
    //firebase instance

    try {
      await FirebaseFirestore.instance.collection('SecurityData').doc(userId).set(securityData.toJson());
    } catch (e) {
      print(e);
    }
  }*/




}
