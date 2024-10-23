import 'package:flutter/material.dart';
import 'package:note_keeper/DataBaseHelper.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget{

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DataBaseHelper db = DataBaseHelper.db;
  List<Map<String,dynamic>> mNotes=[];

  @override
  void initState() {
    getAllNotes();
    super.initState();
  }

  getAllNotes() async{
    mNotes = await DataBaseHelper.db.fetchAllData();
    setState(() {

    });


  }

  @override
  Widget build(BuildContext context) {
 return Scaffold(
   appBar: AppBar(
     centerTitle: true,
     title: Text("NOTES",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Colors.white),),
   ),

   body: ListView.builder(
     itemCount: mNotes.length,
       itemBuilder: (context,index){
     return ListTile(
       leading: Text("${index+1}",style: TextStyle(color: Colors.black),),
       title: Text(mNotes[index][DataBaseHelper.User_Table_Title],style: TextStyle(color: Colors.black),),
       subtitle: Text(mNotes[index][DataBaseHelper.User_Table_Description]),
     );
   }),
   floatingActionButton: FloatingActionButton(
     onPressed: () async{
      bool rowCheck = await DataBaseHelper.db.InsertData(title: "Hello", desc: "I am fine");
      if(rowCheck) {
        getAllNotes();
      }
     },
     child:Icon(Icons.add)
   ),
 );
  }
}