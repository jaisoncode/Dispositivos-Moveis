import 'package:minha_loja_app/models/item_venda.dart';
import 'package:minha_loja_app/models/venda.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VendaRepository {
  late Database _db;

  Future<void> inicializarDB() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'vendas_database.db');

    _db = await openDatabase(databasePath, version: 1, onCreate: (db, version) async {
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

  Future<int> inserirVenda(Venda venda) async {
    final vendaId = await _db.insert('vendas', {'valor_total': venda.valorTotal});
    await _inserirItensVenda(vendaId, venda.itensVendidos);
    return vendaId;
  }

  Future<void> _inserirItensVenda(int vendaId, List<ItemVenda> itensVenda) async {
    final batch = _db.batch();
    for (var item in itensVenda) {
      batch.insert('itens_vendas', {
        'venda_id': vendaId,
        'nome': item.nome,
        'quantidade': item.quantidade,
        'valor': item.valor,
      });
    }
    await batch.commit(noResult: true);
  }

  Future<List<Venda>> buscarVendas() async {
    final List<Map<String, dynamic>> vendas = await _db.query('vendas');
    return _converterVendas(vendas);
  }

  List<Venda> _converterVendas(List<Map<String, dynamic>> vendas) {
    return vendas.map((venda) {
      final vendaId = venda['id'] as int;
      final valorTotal = venda['valor_total'] as double;

      return Venda(
        id: vendaId,
        valorTotal: valorTotal,
        itensVendidos: [], // Ainda não carregados aqui, é possível carregá-los com uma nova consulta
      );
    }).toList();
  }

  Future<List<ItemVenda>> buscarItensVenda(int vendaId) async {
    final itensVenda = await _db.query('itens_vendas', where: 'venda_id = ?', whereArgs: [vendaId]);
    return _converterItensVenda(itensVenda);
  }

  List<ItemVenda> _converterItensVenda(List<Map<String, dynamic>> itensVenda) {
    return itensVenda.map((item) {
      return ItemVenda(
        id: item['id'] as int,
        nome: item['nome'] as String,
        quantidade: item['quantidade'] as int,
        valor: item['valor'] as double,
      );
    }).toList();
  }
}