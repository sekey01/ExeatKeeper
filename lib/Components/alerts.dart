import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider/local_storage/StoreCredentials.dart';
import 'Notify.dart';



/// Alert to delete a single student
void alertDeleteStudent(BuildContext context, int id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Delete',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Student',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        color: Colors.red,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
              )
          ),
        ),
        content: const Text('Do you want to Delete this student ?', style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes', style: TextStyle(color: Colors.red),),
            onPressed: () {
               Provider.of<LocalStorageProvider>(context, listen: false).deleteStudent(id);
                            Notify(context, 'Student removed', Colors.red);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void alertDeleteAllStudent(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'DeleteAll',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Students',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        color: Colors.red,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
              )
          ),
        ),
        content: const Text('Do you want to delete All student ?', style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes', style: TextStyle(color: Colors.red),),
            onPressed: () {
              Provider.of<LocalStorageProvider>(context, listen: false).deleteAllStudents();
              Notify(context, 'All students removed', Colors.red);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


///Exeat alerts
///
void alertDeleteExeat(BuildContext context, int id) {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Delete',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Exeat',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        color: Colors.red,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
              )
          ),
        ),
        content: const Text('Do you want to Delete this Exeat ?', style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes', style: TextStyle(color: Colors.red),),
            onPressed: () {
              Provider.of<LocalStorageProvider>(context, listen: false).deleteExeat(id);
              Notify(context, 'Exeat Deleted', Colors.red);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void alertDeleteAllexeat(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'DeleteAll',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Exeats',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        color: Colors.red,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
              )
          ),
        ),
        content: const Text('Do you want to delete All Exeats ?', style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes', style: TextStyle(color: Colors.red),),
            onPressed: () {
              Provider.of<LocalStorageProvider>(context, listen: false).deleteAllExeats();
              Notify(context, 'All Exeats removed', Colors.red);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



///Security alerts
///
void alertDeleteSecurity(BuildContext context, int id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Delete',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Security',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        color: Colors.red,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
              )
          ),
        ),
        content: const Text('Do you want to  Remove this Security ?', style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes', style: TextStyle(color: Colors.red),),
            onPressed: () {
              Provider.of<LocalStorageProvider>(context, listen: false).deleteSecurityDetail(id);
              Notify(context, 'Security Removed', Colors.red);
              Navigator.of(context).pop();
              Navigator.of(context).pop();


            },
          ),
        ],
      );
    },
  );
}

void alertDeleteAllSecurity(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'DeleteAll',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Security',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        color: Colors.red,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
              )
          ),
        ),
        content: const Text('Do you want to delete All securities ?', style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes', style: TextStyle(color: Colors.red),),
            onPressed: () {
              Provider.of<LocalStorageProvider>(context, listen: false).deleteAllSecurity();


              Notify(context, 'All Securities Removed', Colors.red);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}