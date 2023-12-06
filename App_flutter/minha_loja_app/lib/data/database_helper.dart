import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() => _instance;

  DBHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'vendas_database.db');

    return await openDatabase(databasePath, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE vendas (
          id INTEGER PRIMARY KEY,
          valor_total REAL
        )
      ''');

      await db.execute('''
        CREATE TABLE itens_vendas (
          id INTEGER PRIMARY KEY,
          venda_id INTEGER,
          nome TEXT,
          quantidade INTEGER,
          valor REAL,
          FOREIGN KEY (venda_id) REFERENCES vendas(id) ON DELETE CASCADE
        )
      ''');
    });
  }

  Future<int> inserirVenda(Map<String, dynamic> venda, List<Map<String, dynamic>> itensVenda) async {
  final db = await database;
  int vendaId = await db.insert('vendas', venda);
  for (var item in itensVenda) {
    item['venda_id'] = vendaId;
    await db.insert('itens_vendas', item);
  }
  return vendaId;
}

  Future<int> inserirItemVenda(Map<String, dynamic> itemVenda) async {
    final db = await database;
    return await db.insert('itens_vendas', itemVenda);
  }

  Future<List<Map<String, dynamic>>> buscarVendas() async {
    final db = await database;
    return await db.query('vendas');
  }

  Future<List<Map<String, dynamic>>> buscarItensVenda(int vendaId) async {
    final db = await database;
    return await db.query('itens_vendas', where: 'venda_id = ?', whereArgs: [vendaId]);
  }
}
