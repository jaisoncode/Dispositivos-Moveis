import 'package:flutter/material.dart';
import 'package:minha_loja_app/data/database_helper.dart';
import 'package:minha_loja_app/models/item_venda.dart';
import 'package:minha_loja_app/models/venda.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int _paginaAtual =
      0; // Índice da página atual (0 para a página Home, 1 para a página Venda)

  final List<Widget> _paginas = [
    TelaHome(),
    TelaVenda(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha loja'),
      ),
      body: _paginas[_paginaAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaAtual,
        onTap: (index) {
          setState(() {
            _paginaAtual = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Venda',
          ),
        ],
      ),
    );
  }
}

class TelaHome extends StatelessWidget {
  final DBHelper dbHelper = DBHelper();

  Future<int> _getQuantidadeItensVendidos() async {
    List<Map<String, dynamic>> vendas = await dbHelper.buscarVendas();
    int quantidadeItens = 0;
    for (var venda in vendas) {
      List<Map<String, dynamic>> itensVenda =
          await dbHelper.buscarItensVenda(venda['id']);
      quantidadeItens += itensVenda.length;
    }
    print("${quantidadeItens}  itens vendidos");
    return quantidadeItens;
  }

  Future<double> _getValorTotalVendas() async {
    List<Map<String, dynamic>> vendas = await dbHelper.buscarVendas();
    double valorTotal = 0;
    for (var venda in vendas) {
      valorTotal += venda['valor_total'];
    }
    print("${valorTotal}  valor total vendidos");
    return valorTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatórios'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<int>(
              future: _getQuantidadeItensVendidos(),
              builder: (context, snapshot) {
                return Card(
                  child: ListTile(
                    title: Text('Quantidade de Itens Vendidos'),
                    subtitle: Text(snapshot.hasData
                        ? '${snapshot.data}'
                        : 'Carregando...'),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            FutureBuilder<double>(
              future: _getValorTotalVendas(),
              builder: (context, snapshot) {
                return Card(
                  child: ListTile(
                    title: Text('Valor Total das Vendas'),
                    subtitle: Text(snapshot.hasData
                        ? 'R\$ ${snapshot.data?.toStringAsFixed(2)}'
                        : 'Carregando...'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TelaVenda extends StatefulWidget {
  @override
  _TelaVendaState createState() => _TelaVendaState();
}

class _TelaVendaState extends State<TelaVenda> {
  final List<Map<String, dynamic>> _itensVenda = [];
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  double get valorTotalVenda {
    double total = 0;
    for (var item in _itensVenda) {
      total += item['quantidade'] * item['valor'];
    }
    return total;
  }

  void _adicionarItem() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome do Produto'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _quantidadeController,
                decoration: InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _valorController,
                decoration: InputDecoration(labelText: 'Valor Unitário'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _adicionarItemNaLista();
                Navigator.of(context).pop();
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _adicionarItemNaLista() {
    final String nome = _nomeController.text;
    final int quantidade = int.tryParse(_quantidadeController.text) ?? 0;
    final double valor = double.tryParse(_valorController.text) ?? 0.0;

    if (nome.isNotEmpty && quantidade > 0 && valor > 0) {
      _itensVenda.add({'nome': nome, 'quantidade': quantidade, 'valor': valor});

      _nomeController.clear();
      _quantidadeController.clear();
      _valorController.clear();

      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos corretamente.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _finalizarVenda() async {
    if (_itensVenda.isNotEmpty) {
      List<Map<String, dynamic>> itens = [];
      for (var item in _itensVenda) {
        itens.add({
          'nome': item['nome'],
          'quantidade': item['quantidade'],
          'valor': item['valor'],
        });
      }

      Map<String, dynamic> venda = {
        'valor_Total': valorTotalVenda,
      };

      print("${itens} os itens - os valor ${venda}");
      int vendaId = await DBHelper().inserirVenda(venda, itens);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Venda finalizada e salva no banco de dados.'),
        ),
      );

      setState(() {
        _itensVenda.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Adicione pelo menos um item à venda.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_itensVenda.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var item in _itensVenda)
                    ListTile(
                      title: Text(item['nome']),
                      subtitle: Text(
                          'Qtd: ${item['quantidade']}, Valor: ${item['valor']}'),
                    ),
                  SizedBox(height: 10),
                  Text(
                    'Valor Total da Venda: R\$ ${valorTotalVenda.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _finalizarVenda,
                    child: Text('Finalizar Venda'),
                  ),
                ],
              ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 40, // Largura desejada do botão flutuante
                height: 40, // Altura desejada do botão flutuante
                child: FloatingActionButton(
                  onPressed: _adicionarItem,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.add, color: Colors.white),
                  tooltip: 'Adicionar Item',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
