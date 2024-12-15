import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class DownloadFunction extends ChangeNotifier {


 /* ///  FUNCTION TO CALL A SCHOOL DETAILS with ID THAT MATCHES WITH  ID Value FROM SUPABASE DATABASE TABLE 'HouseFather' in the column 'schooldetails' of datatype json
  Future<SchoolDetail> getSchoolDetails(String id) async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('HouseFather').select().eq('id', id).execute();
    if (response.error != null) {
      throw response.error!;
    }
    if (response.data == null || response.data!.length == 0) {
      throw Exception('No data found');
    }
    return SchoolDetail.fromJson(response.data![0]['schooldetails']);
  }*/
}

///  FUNCTION TO CALL A SCHOOL DETAILS with ID THAT MATCHES WITH  ID Value FROM SUPABASE DATABASE TABLE 'HouseFather' in the column 'schooldetails' of datatype json
/*
Future<StudentDetailMo> getSchoolDetails(String id) async {
  final supabase = Supabase.instance.client;
  final response = await supabase.from('HouseFather').select('').eq('id', id);
  print(response.toString());
  return StudentDetail.fromJson(response[0]['schooldetails']);
}*/
