import 'package:minha_loja_app/models/item_venda.dart';

class Venda {
  final int id;
  final List<ItemVenda> itensVendidos;
  final double valorTotal;

  Venda({required this.id, required this.itensVendidos, required this.valorTotal});
}

