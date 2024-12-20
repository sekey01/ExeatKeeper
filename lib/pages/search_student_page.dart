import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ek/provider/local_storage/StoreCredentials.dart';
import '../Components/alerts.dart';
import '../Components/simple row.dart';
import '../Models/student_datail_model.dart';

class StudentSearch extends StatefulWidget {
  const StudentSearch({super.key});

  @override
  State<StudentSearch> createState() => _StudentSearchState();
}

class _StudentSearchState extends State<StudentSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<StudentDetailModel> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  void _searchStudents(String query) async {
    final results = await Provider.of<LocalStorageProvider>(context, listen: false).searchStudents(query);
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Students'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            ///SEARCH BAR
            ///
            ///
            child:  Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(

                controller: _searchController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Search Student',
                  fillColor: Colors.blueGrey.shade100,
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();},
                    icon: const Icon(
                      Icons.clear_sharp,
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blueGrey,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.circular(10),

                    ///borderSide: BorderSide(color: Colors.red),
                  ),

                  hintStyle: TextStyle(
                    fontFamily: 'QuickSand',
                    color: Colors.black,
                    fontSize: 10.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.blueGrey,
                      style: BorderStyle.solid,
                    ),
                  ),
                  label: const Text('Search Student'),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 10.spMin,fontFamily: 'QuickSand',),
                ),
                onChanged: (value) {
                  _searchStudents(value);

                  /// Trigger rebuild to update search results
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final student = _searchResults[index];
               final  studentNumber = index;
                return  InkWell(
                  onLongPress: () {
                    alertDeleteStudent(context, studentNumber);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      collapsedShape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      iconColor: Colors.black,
                      collapsedBackgroundColor: Colors.grey.shade300,

                      title: Text(
                        ' ${student.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'QuickSand',
                          color: Colors.black,
                          fontSize: 15.sp,
                        ),
                      ),
                      leading: const CircleAvatar(child: Icon(Icons.school_outlined, color: Colors.black,)),
                      children: [
                        StudentDetailRow(label: 'Name', value: student.name),
                        StudentDetailRow(label: 'Class', value: student.classRoom),
                        StudentDetailRow(label: 'Location', value: student.location.toString()),
                        StudentDetailRow(label: 'Room Number', value: student.roomNumber.toString()),
                        StudentDetailRow(label: 'Parent Tell', value: student.parentTell.toString()),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}