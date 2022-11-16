import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model.dart';

class HomePageController extends GetxController {
  var userData = <Phones>[].obs;
  @override
  // void onInit() {
  //   createDatabase();
  //   super.onInit();
  // }

  Future<void> createDatabase() async {
    String path = join(await getDatabasesPath(), "db_ph");
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      printInfo(info: "db:" + db.toString());
      await db.execute('''CREATE TABLE tbl_list(
      id TEXT NOT NULL,
      name TEXT NOT NULL,
      phone TEXT NOT NULL,
      email TEXT NOT NULL,
      image TEXT NoT NULL
      )''');
    });
    getData();
  }

  addData({String? name, String? phone, String? email, String? image}) {
    var user = Phones(
        name: name,
        phone: phone,
        email: email,
        image: image,
        id: (userData.length + 1).toString());
    insertData(user);
  }

  Future<void> insertData(Phones user) async {
    String path = join(await getDatabasesPath(), "db_ph");
    final db = await openDatabase(path);
    await db.insert("tbl_list", user.toJson());
    print(user.toJson());
    getData();
  }

  Future<void> getData() async {
    userData.clear();
    String path = join(await getDatabasesPath(), "db_ph");
    final db = await openDatabase(path);
    final List<Map<String, dynamic>> maps = await db.query("tbl_list");
    userData.addAll(maps.map((e) => Phones.fromJson(e)).toList());
    print(userData.value);
  }
  deleteDatabase({String? id}) async {
    String path = join(await getDatabasesPath(), "db_ph");
    final db = await openDatabase(path);
    getData();
    print("Recode DataDelete");
    return await db.delete("tbl_list", where: 'id = ?', whereArgs: [id]);
  }

  updateDatabase(Phones user) async {
    print(user.id);
    String path = join(await getDatabasesPath(), "db_ph");
    final db = await openDatabase(path);
    getData();
    print("Recode update");
    return await db.update("tbl_list", user.toJson(),
        where: 'id = ?', whereArgs: [user.id]);
  }
}
