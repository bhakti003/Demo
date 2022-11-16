import 'package:call/model.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PageConroller extends GetxController{
  var userData = <Phones>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> createData() async{
    String path = join(await getDatabasesPath(),"db_user");
    await openDatabase(path,version: 1,
    onCreate: (Database db,int version) async {
     printInfo(info: "db" + db.toString());
     await db.execute('''CREATE TABLE tbl_data(
     id TEXT NOT NULL,
     name TEXT NOT NULL,
     phone TEXT NOT NULL,
     email TEXT NOT NULL,
     image TEXT NOT NULL
     )''');
    }
    );
    getData();
  }
  Future<void> getData() async{
    userData.clear();
    String path = join(await getDatabasesPath(),'db_user');
    final db = await openDatabase(path);
    final List<Map<String ,dynamic>> maps = await db.query("tbl_user");
    userData.addAll(maps.map((e) => Phones.fromJson(e)).toList());
  }
  Future<void> insertData(Phones user) async{
    String path = join (await getDatabasesPath(),'db_user');
    final db = await openDatabase(path);
    await db.insert("tbl_data", user.toJson());
    getData();
  }
 addData({String? image , String? name , String? email,String? phone}) async{
    var user = Phones(image: image,id: (userData.length + 1 ).toString());
    insertData(user);
 }
  deleteData({String? id}) async{
    String path = join (await getDatabasesPath(),'db_user');
    final db = await openDatabase(path);
    getData();
    print("Recodde delete");
    return await db.delete('tbl_data', where: 'id = ?' , whereArgs: [id]);
  }
  updateData(Phones user) async{
    String path = join (await getDatabasesPath(),'db_user');
    final db = await openDatabase(path);
    getData();
    print("Recode Update");
    return await db.update("tbl_user", user.toJson() , whereArgs: [user.id] ,where: 'id = ?');
  }

}