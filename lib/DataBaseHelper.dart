
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DataBaseHelper {

  //Making Singleton (Private Constructor)

  DataBaseHelper._();

 static final  DataBaseHelper db = DataBaseHelper._();

  static const String User_Database="NotesDatabase.db";
  static const String User_Table = "user_table";
  static const String User_Table_ID = "id";
  static const String User_Table_Title = "title";
  static const String User_Table_Description = "description";

  //Database Initialisation

  Database? mdb;

  //Get DataBase
  Future<Database> getDataBase() async {
    if (mdb != null) {
      return mdb!;
    } else {
      mdb = await OpenDB();
      return mdb!;
    }
  }

  Future<Database> OpenDB() async {
    var rootPath = await getApplicationDocumentsDirectory();
    var dbPath = join(rootPath.path, "NotesDatabase.db");
    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute(
          " Create Table $User_Table ( $User_Table_ID integer primary key autoincrement , $User_Table_Title text , $User_Table_Description text)");
    });
  }


  Future<bool> InsertData({required String title, required String desc}) async {
    var mainDataBase = await getDataBase();
    int rowCheck = await mainDataBase.insert(User_Table, {
      title : User_Table_Title,
      desc : User_Table_Description
    });
    return rowCheck>0;
  }

Future<List<Map<String,dynamic>>> fetchAllData() async{
    var mainDataBase = await getDataBase();
    List<Map<String, dynamic>> mNotes= await mainDataBase.query(User_Table);
    return mNotes;

  }

  Future<bool> updateData(String title, String desc ,int id) async {
                var mainDataBase = await getDataBase();
            int rowCheck = await mainDataBase.update(User_Table, {
                  title:User_Table_Title,
                  desc:User_Table_Description
                }, where: " $User_Table_ID = $id");
            return rowCheck>0;
                }

                Future<bool> deleteData(int index) async{
                var mainDataBase = await getDataBase();
                int rowCheck= await mainDataBase.delete(User_Table);
                 return rowCheck>0;
                }
}
