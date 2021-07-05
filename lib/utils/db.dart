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
          'CREATE TABLE IF NOT EXISTS chats(id INTEGER PRIMARY KEY, text TEXT, image BLOB)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertChats(Data? chatData) async {
  final db = await this.database;
  await db!.insert(
    'chats',
    chatData!.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Data?>> getChats() async {
  // Get a reference to the database.
  final db = await this.database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db!.query('chats');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Data(
      text: maps[i]['text']
    );
  });
}

  Future<void> dbClose() async {
    if (null != _database) {
      await _database!.close();
    }
  }
}
