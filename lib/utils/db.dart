import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ChatDataBase {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future initDatabase() async {
    String path = join(await getDatabasesPath(), "alice_chat.db");
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS chats(text TEXT, image_url TEXT , source TEXT, type TEXT, sub_type TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertChats(DataSource? chatData) async {
  final db = await this.database;
  await db!.insert(
    'chats',
    chatData!.toJsonForDB(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<DataSource?>> getChats() async {
  // Get a reference to the database.
  final db = await this.database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db!.query('chats');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return DataSource(
      text: maps[i]['text'],
      imageUrl: maps[i]["image_url"],
      source: maps[i]["source"],
      type: maps[i]["type"],
      subType: maps[i]["sub_type"]
    );
  });
}

  Future<void> dbClose() async {
    await _database!.close();
  }
}
