import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ek/provider/local_storage/StoreCredentials.dart';
import 'package:ek/Models/sign_exeat_model.dart';
import '../Components/alerts.dart';
import '../Components/simple row.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final TextEditingController _searchController = TextEditingController();
  List<SignExeatModel> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchExeats(String query) async {
    final results = await Provider.of<LocalStorageProvider>(context, listen: false).searchExeats(query);
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Exeat',
                    style: TextStyle(
                      fontFamily: 'Righteous',
                      color: Colors.black,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'History',
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
                  hintText: 'search student',
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
                      color: Colors.deepOrangeAccent,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.circular(10),

                    ///borderSide: BorderSide(color: Colors.red),
                  ),

                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 10.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.deepOrangeAccent,
                      style: BorderStyle.solid,
                    ),
                  ),
                  label: const Text('search student'),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 10.spMin),
                ),
                onChanged: (value) {
                  _searchExeats(value);

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
                final exeat = _searchResults[index];
                final exeat_number = index;
                return  InkWell(
                  onLongPress: () {
                    alertDeleteExeat(context, exeat_number);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Badge(
                      alignment: Alignment.topCenter,
                      label: Text(exeat.isBack ? 'Signed In' : 'Signed Out', style: TextStyle(color: Colors.white, fontSize: 10.spMin),),
                      backgroundColor: exeat.isBack ? Colors.green : Colors.red,
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
                          ' ${exeat.name}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        leading: const CircleAvatar(child: ImageIcon(AssetImage('assets/Icon/student.png'), size: 25, color: Colors.black,),
                        ),
                        children: [
                          StudentDetailRow(label: 'Name', value: exeat.name),
                          StudentDetailRow(label: 'To', value: exeat.to),
                          StudentDetailRow(label: 'Reason', value: exeat.reason),
                          StudentDetailRow(label: 'Departure', value: exeat.time),

                        ],

                      ),
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