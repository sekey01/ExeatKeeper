import 'dart:convert';
import 'dart:io';

import 'package:ek/Models/student_datail_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../../Models/school_details_model.dart';
import '../../Models/security_data_model.dart';
import '../../Models/sign_exeat_model.dart';

class LocalStorageProvider extends ChangeNotifier {
  /// Just making use of this Provider to get the upgdated value for the notification page
  int notificationLength = 1;

  ///

  String phoneNumber = '';
  String userName = '';

  String email = '';

  String id = '';

  String adminEmail = '';
  String locationName = '';
  String isLoggedIn = 'false';

   /// STORE PROFILE PICTURE
  Future<void> saveProfilePicture(File imageFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/picture.png';
      final file = File(filepath);

      // Delete the existing file if it exists
      if (await file.exists()) {
        await file.delete();
      }

      // Write the new image file
      await file.writeAsBytes(await imageFile.readAsBytes());

      print('Profile picture saved at $filepath');
    } catch (e) {
      print('Error saving profile picture: $e');
    }
    notifyListeners();
  }

  ///GET PROFILE PICTURE
  Future<File?> getProfilePicture() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/picture.png';
      final file = File(filepath);

      if (await file.exists()) {
        notifyListeners();
        return file;
      } else {
        print('Profile picture not found');
        return null;
      }
    } catch (e) {
      print('Error getting profile picture: $e');
      return null;
    }
  }




  /// STORE PHONE NUMBER
  Future<void> storePhoneNumber(String newValue) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/storePhoneNumber.txt';
      final file = File(filepath);

      // Check if the file exists
      if (!await file.exists()) {
        await file.create(
            recursive: true); // Create the file if it doesn't exist
      }

      // Write the new value to the file
      await file.writeAsString(newValue);

      // Update the telephone Number
      phoneNumber = newValue;
      print(phoneNumber);
      // Notify listeners of the change
      notifyListeners();
    } catch (e) {
      // Handle any exceptions
      print("Error changing phoneNumber: $e");
      // You can throw the error or handle it as needed
    }
  }
  ///GET PHONE NUMBER
  Future <String> getPhoneNumber() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/storePhoneNumber.txt';
      final file = File(filepath);

      // Check if the file exists
      if (await file.exists()) {
        // Read the contents of the file
        String contents = await file.readAsString();
        phoneNumber = contents; // Parse the contents to an integer
        notifyListeners();

        return phoneNumber;
      } else {
        return phoneNumber =
        'Add Phone Number'; // Default value if the file doesn't exist
      }

      // Notify listeners of the change
    } catch (e) {
      // Handle any exceptions
      return 'Username';
      //print("Error loading Username: $e");
      // You can throw the error or handle it as needed
    }
  }



/// STORE USERNAME FOR HOUSE FATHER
  Future<void> storeUsername(String newValue) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/Username.txt';
      final file = File(filepath);

      // Check if the file exists
      if (!await file.exists()) {
        await file.create(
            recursive: true); // Create the file if it doesn't exist
      }

      // Write the new value to the file
      await file.writeAsString(newValue);

      // Update the telephone Number
      userName = newValue;

      // Notify listeners of the change
      notifyListeners();
    } catch (e) {
      // Handle any exceptions
      print("Error changing Username: $e");
      // You can throw the error or handle it as needed
    }
  }

///GET USERNAME FOR HOUSE FATHER
  Future <String> getUsername() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/Username.txt';
      final file = File(filepath);

      // Check if the file exists
      if (await file.exists()) {
        // Read the contents of the file
        String contents = await file.readAsString();
        userName = contents; // Parse the contents to an integer
        notifyListeners();
        return userName;

      } else {
        return userName = 'Username'; // Default value if the file doesn't exist
      }

      // Notify listeners of the change
      notifyListeners();
    } catch (e) {
      // Handle any exceptions
      return 'Username';
      //print("Error loading Username: $e");
      // You can throw the error or handle it as needed
    }
  }



  /// STORE USER EMAIL HERE
  ///
  Future<void> storeEmail(String newValue) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/email.txt';
      final file = File(filepath);

      // Check if the file exists
      if (!await file.exists()) {
        await file.create(
            recursive: true); // Create the file if it doesn't exist
      }

      // Write the new value to the file
      await file.writeAsString(newValue);

      // Update the telephone Number
      email = newValue;

      // Notify listeners of the change
      notifyListeners();
    } catch (e) {
      // Handle any exceptions
      //print("Error changing email: $e");
      // You can throw the error or handle it as needed
    }
  }

  ///GET EMAIL HERE
  ///
  Future <String> getEmail() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/email.txt';
      final file = File(filepath);

      // Check if the file exists
      if (await file.exists()) {
        // Read the contents of the file
        String contents = await file.readAsString();
        email = contents; // Parse the contents to an integer
        notifyListeners();

        return email;
      } else {
        return email =
        ' mealmate@gmail.com'; // Default value if the file doesn't exist
      }
    } catch (e) {
      // Handle any exceptions
      return '@username';
      // print("Error loading Username: $e");
      // You can throw the error or handle it as needed
    }
  }


  /// STORE ADMIN EMAIL HERE
  ///
  Future<void> storeAdminEmail(String newValue) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/adminEmail.txt';
      final file = File(filepath);

      // Check if the file exists
      if (!await file.exists()) {
        await file.create(
            recursive: true); // Create the file if it doesn't exist
      }

      // Write the new value to the file
      await file.writeAsString(newValue);

      // Update the telephone Number
      adminEmail = newValue;

      // Notify listeners of the change
      notifyListeners();
    } catch (e) {
      // Handle any exceptions
      //print("Error changing email: $e");
      // You can throw the error or handle it as needed
    }
  }

  ///GET EMAIL HERE
  ///
  Future <String> getAdminEmail() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/adminEmail.txt';
      final file = File(filepath);

      // Check if the file exists
      if (await file.exists()) {
        // Read the contents of the file
        String contents = await file.readAsString();
        adminEmail = contents; // Parse the contents to an integer
        notifyListeners();

        return adminEmail;
      } else {
        return adminEmail =
        ' mealmate@gmail.com'; // Default value if the file doesn't exist
      }
    } catch (e) {
      // Handle any exceptions
      return 'adminemail@gmail.com';
      // print("Error loading Username: $e");
      // You can throw the error or handle it as needed
    }
  }


  /// STORE LOCATION HERE
  ///
  Future<void> storeLocation(String newValue) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/location.txt';
      final file = File(filepath);

      // Check if the file exists
      if (!await file.exists()) {
        await file.create(
            recursive: true); // Create the file if it doesn't exist
      }

      // Write the new value to the file
      await file.writeAsString(newValue);

      // Update the telephone Number
      locationName = newValue;

      // Notify listeners of the change
      notifyListeners();
    } catch (e) {
      // Handle any exceptions
      //print("Error changing email: $e");
      // You can throw the error or handle it as needed
    }
  }

  ///GET EMAIL HERE
  ///
  Future <String> getLocationName() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/location.txt';
      final file = File(filepath);

      // Check if the file exists
      if (await file.exists()) {
        // Read the contents of the file
        String contents = await file.readAsString();
        locationName = contents; // Parse the contents to an integer
        notifyListeners();

        return locationName;
      } else {
        return locationName =
        ' Tap to set location'; // Default value if the file doesn't exist
      }
    } catch (e) {
      // Handle any exceptions
      return 'reset location';
      // print("Error loading Username: $e");
      // You can throw the error or handle it as needed
    }
  }


  /// STORE ID HERE
  ///
  ///

  Future<void> storeId(String newValue) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/id.txt';
      final file = File(filepath);

      // Check if the file exists
      if (!await file.exists()) {
        await file.create(
            recursive: true); // Create the file if it doesn't exist
      }

      // Write the new value to the file
      await file.writeAsString(newValue);

      // Update the telephone Number
      id = newValue;

      // Notify listeners of the change
      notifyListeners();
    } catch (e) {
      // Handle any exceptions
      print("Error changing id: $e");
      // You can throw the error or handle it as needed
    }
  }

  ///GET ID HERE
  ///
  Future <String> getId() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/id.txt';
      final file = File(filepath);

      // Check if the file exists
      if (await file.exists()) {
        // Read the contents of the file
        String contents = await file.readAsString();
        id = contents; // Parse the contents to an integer

        return id;
      } else {
        return ' Error : No Id Found'; // Default value if the file doesn't exist
      }
    } catch (e) {
      // Handle any exceptions
      return 'Error: $e';
      // print("Error loading Username: $e");
      // You can throw the error or handle it as needed
    }
  }

  Future<void> storeLoginStatus(String status) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/loginStatus.txt';
      final file = File(filepath);

      if (!await file.exists()) {
        await file.create(recursive: true);
      }

      await file.writeAsString(status.toString());
      isLoggedIn = status;
      notifyListeners();
    } catch (e) {
      print("Error changing login status: $e");
    }
  }
  Future<String> getLoginStatus(BuildContext context) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/loginStatus.txt';
      final file = File(filepath);

      if (await file.exists()) {
        String contents = await file.readAsString();
        isLoggedIn = contents.toLowerCase();
        isLoggedIn == 'true'
            ? Navigator.pushReplacementNamed(context, '/home')
            : Navigator.pushReplacementNamed(context, '/login');

        return isLoggedIn;
      } else {
        print('No login status found');
        Navigator.pushReplacementNamed(context, '/login');
        return 'false';}
    } catch (e) {
      return 'false';
    }
  }





/// STORE STUDENT DETAILS HERE
  ///
  ///
  ///
  ///
  String fileName = 'studentDetailsList.json';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<void> addStudents(List<StudentDetailModel> studentDetail) async {
    final file = await _localFile;
    if (!await file.exists()) {
      await file.create(
          recursive: true); // Create the file if it doesn't exist
    }
    final data = studentDetail.map((x) => x.toJson()).toList();
    print(data);
    await file.writeAsString(json.encode(data));
  }

  Future<List<StudentDetailModel>> loadStudents() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final data = json.decode(contents) as List;
      print('LOAD STUDENTS CALLED ');

      return data.map((x) => StudentDetailModel.fromJson(x)).toList();
    } catch (e) {
      print('Load Students Error: $e');
      // If encountering an error, return an empty list
      return [];
    }
  }

  Future<void> addStudent(StudentDetailModel storeStudent) async {
    final students = await loadStudents();
    students.add(storeStudent);
    await addStudents(students);
  }

  Future<void> deleteAllStudents() async {
    final file = await _localFile;
    if (await file.exists()) {
      await file.delete(); // Delete the file
    }
  }

  Future<void> deleteStudent(int index) async {
    try {
      final students = await loadStudents();
      if (index >= 0 && index < students.length) {
        students.removeAt(index);
        await addStudents(students);
        notifyListeners();
      } else {
        print('Index out of range');
      }
    } catch (e) {
      print('Error deleting student: $e');
    }
  }

  Future<List<StudentDetailModel>> searchStudents(String query) async {
    final students = await loadStudents();
    return students.where((student) {
      return student.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }












  /// STORE EXEAT HERE
  ///
  ///
  ///
  String fileExeatName = 'studentExeatList.json';

  Future<String> get _localExeatPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localExeatFile async {
    final path = await _localExeatPath;
    return File('$path/$fileExeatName');
  }

  Future<void> addExeats(List<SignExeatModel> exeat) async {
    final file = await _localExeatFile;
    if (!await file.exists()) {
      await file.create(
          recursive: true); // Create the file if it doesn't exist
    }
    final data = exeat.map((x) => x.toJson()).toList();
   // print(data);
    await file.writeAsString(json.encode(data));
  }


  Future<void> updateIsBackStatus(int index, bool status) async {
    try {
      final exeats = await loadExeats();
      if (index >= 0 && index < exeats.length) {
        exeats[index].isBack = status;
        await addExeats(exeats);
        notifyListeners();
      } else {
      //  print('Index out of range');
      }
    } catch (e) {
     // print('Error updating isBack status: $e');
    }
  }



  Future<List<SignExeatModel>> loadExeats() async {
    try {
      final file = await _localExeatFile;
      final contents = await file.readAsString();
      final data = json.decode(contents) as List;
     // print('LOAD EXEATS CALLED ');

      return data.map((x) => SignExeatModel.fromJson(x)).toList();
    } catch (e) {
      //print('Load Exeats Error: $e');
      // If encountering an error, return an empty list
      return [];
    }
  }

  Future<void> addExeat(SignExeatModel storeExeat) async {
    final students = await loadExeats();
    students.add(storeExeat);
    await addExeats(students);
  }

  Future<void> deleteAllExeats() async {
    final file = await _localExeatFile;
    if (await file.exists()) {
      await file.delete(); // Delete the file
    }
  }

  Future<void> deleteExeat(int index) async {
    try {
      final exeat = await loadExeats();
      if (index >= 0 && index < exeat.length) {
        exeat.removeAt(index);
        await addExeats(exeat);
        notifyListeners();
      } else {
     //   print('Index out of range');
      }
    } catch (e) {
   //   print('Error deleting student: $e');
    }
  }


  Future<List<SignExeatModel>> searchExeats(String query) async {
    final exeats = await loadExeats();
    return exeats.where((exeat) {
      return exeat.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }











///// SECURITY DETAILS




  String fileSecurityName = 'securityDetailsList.json';

  Future<String> get _localSecurityPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localSecurityFile async {
    final path = await _localSecurityPath;
    return File('$path/$fileSecurityName');
  }
///ADD SECURITY DETAILS JUST TO LOAD
  Future<void> addSecurityDetails(List<SecurityDetailsModel> securityDetails) async {
    final file = await _localSecurityFile;
    if (!await file.exists()) {
      await file.create(recursive: true); // Create the file if it doesn't exist
    }
    final data = securityDetails.map((x) => x.toJson()).toList();
    //print(data);
    await file.writeAsString(json.encode(data));
  }


///ACTUAL FUNCTION TO ADD SECURITY DETAILS
  Future<void> addSecurityDetail(SecurityDetailsModel securityDetail) async {
    final securityDetails = await loadSecurityDetails();
    securityDetails.add(securityDetail);
    await addSecurityDetails(securityDetails);
    notifyListeners();
  }

  Future<List<SecurityDetailsModel>> loadSecurityDetails() async {
    try {
      final file = await _localSecurityFile;
      final contents = await file.readAsString();
      final data = json.decode(contents) as List;
    //  print('LOAD SECURITY DETAILS CALLED ');

      return data.map((x) => SecurityDetailsModel.fromJson(x)).toList();
    } catch (e) {
      print('Load Security Details Error: $e');
      // If encountering an error, return an empty list
      return [];
    }
  }



  Future<void> deleteSecurityDetail(int index) async {
    try {
      final securityDetails = await loadSecurityDetails();
      if (index >= 0 && index < securityDetails.length) {
        securityDetails.removeAt(index);
        await addSecurityDetails(securityDetails);
        notifyListeners();
      } else {
        print('Index out of range');
      }
    } catch (e) {
      print('Error deleting security detail: $e');
    }
  }


  Future<void> deleteAllSecurity() async {
    try {
      final file = await _localSecurityFile;
      if (await file.exists()) {
        await file.delete(); // Delete the file
        notifyListeners();
      }
    } catch (e) {
     // print('Error deleting all security details: $e');
    }
  }





















/// SCHOOL DETAILS
  ///
  ///



  String fileSchoolDetailsName = 'schoolDetails.json';

  Future<String> get _localSchoolPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localSchoolFile async {
    final path = await _localSchoolPath;
    return File('$path/$fileSchoolDetailsName');
  }

/// TO LOAD EXISTING SCHOOL DETAILS AND ADD NEW ONES
  ///
  Future<void> addSchoolDetails(List<SchoolDetailsModel> schoolDetails) async {
    final file = await _localSchoolFile;
    if (!await file.exists()) {
      await file.create(recursive: true); // Create the file if it doesn't exist
    }
    final data = schoolDetails.map((x) => x.toJson()).toList();
    print(data);
    await file.writeAsString(json.encode(data));
  }


  ///ACTUAL FUNCTION TO ADD SCHOOL DETAILS
  Future<void> addSchoolDetail(SchoolDetailsModel schoolDetail) async {
    final file = await _localSchoolFile;
    if (!await file.exists()) {
      await file.create(recursive: true); // Create the file if it doesn't exist
    }
    final data = schoolDetail.toJson();
    await file.writeAsString(json.encode(data));
    notifyListeners();
  }
  Future<SchoolDetailsModel?> loadSchoolDetails() async {
    try {
      final file = await _localSchoolFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final data = json.decode(contents) as Map<String, dynamic>;
        return SchoolDetailsModel.fromJson(data);
      } else {
        return null; // Return null if the file does not exist
      }
    } catch (e) {
      print('Load School Details Error: $e');
      return null; // Return null if an error occurs
    }
  }



/*
  Future<void> deleteSecurityDetail(int index) async {
    try {
      final securityDetails = await loadSecurityDetails();
      if (index >= 0 && index < securityDetails.length) {
        securityDetails.removeAt(index);
        await addSecurityDetails(securityDetails);
        notifyListeners();
      } else {
        print('Index out of range');
      }
    } catch (e) {
      print('Error deleting security detail: $e');
    }
  }
*/


 /* Future<void> deleteAllSecurity() async {
    try {
      final file = await _localSecurityFile;
      if (await file.exists()) {
        await file.delete(); // Delete the file
        notifyListeners();
      }
    } catch (e) {
      print('Error deleting all security details: $e');
    }
  }
*/


@override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }


}

