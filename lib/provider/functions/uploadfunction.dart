/*
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Models/store_student.dart';
import '../../Models/security_data_model.dart';

class UploadFunctionProvider extends ChangeNotifier{
  Future<void> upload(StudentDetail details) async {
    final supabase = Supabase.instance.client;
    // Insert the data
    final response = await supabase.from('HouseFather').insert(
        { 'houseFather': details.toJson()}
    );
  }

  Future<void> addSecuritiy(SecurityDetails details) async {
    final supabase = Supabase.instance.client;
    // Insert the data
    final response = await supabase.from('Security').insert(
        { 'security': details.toJson()}
    );



  }
}*/
