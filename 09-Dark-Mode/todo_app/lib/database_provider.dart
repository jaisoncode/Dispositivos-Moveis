import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static const String TABLE_SETTINGS = 'settings';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_DARK_THEME = 'dark_theme';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), 'todo.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $TABLE_SETTINGS (
            $COLUMN_ID INTEGER PRIMARY KEY,
            $COLUMN_DARK_THEME INTEGER
          )
        ''');
      },
    );
  }

  Future<int> updateDarkTheme(bool isDarkTheme) async {
    final db = await database;
    return db.update(
      TABLE_SETTINGS,
      {COLUMN_DARK_THEME: isDarkTheme ? 1 : 0},
      where: '$COLUMN_ID = ?',
      whereArgs: [1],
    );
  }

  Future<bool> getDarkTheme() async {
    final db = await database;
    final result = await db.query(
      TABLE_SETTINGS,
      where: '$COLUMN_ID = ?',
      whereArgs: [1],
    );
    if (result.isNotEmpty) {
      return result.first[COLUMN_DARK_THEME] == 1 ? true : false;
    }
    return false; 
  }
}
