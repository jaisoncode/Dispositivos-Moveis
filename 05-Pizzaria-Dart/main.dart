import 'dart:io';
import 'dart:math';
import 'Pedido.dart';
import 'Pizza.dart';
import 'dart:core';



List<Pizza> pizzaList = [];
List<Pedido> pedidosList = [];

void main() {
  carregarDados();
  menu();

}

void menu(){
  bool repetir = true;
  while (repetir) {
    print("------------------------------");
    print("1. Cadastrar pizza");
    print("2. Editar pizza");
    print("3. Remover pizza");
    print("4. Fazer Pedido");
    print("5. Listar Pizzas");
    print("6. Listar pedidos");
    print("7. Sair");
    stdout.write("Digite a opção desejada: ");
    var opcao = int.parse(stdin.readLineSync()!);
    print("----------------------------");

    switch (opcao) {
      case 1:
        cadastrarPizza();
        break;
      case 2:
        editarPizza();
        break;
      case 3:
        removerPizza();
        break;
      case 4:
        fazerPedido();
        break;
      case 5:
        listarPizzas();
        break;
      case 6:
        listarPedidos();
        break;
      case 7:
        salvarDados();
        print('Fechando programa...');
        repetir = false;
        break;
      default:
        print("Opção inválida!");
    }
  }

}

void cadastrarPizza() {
  print("-----------  CADASTRAR PIZZA  -----------");
  bool repetir = true;
  while (repetir) {
    var random = Random();
    int codigo = random.nextInt(9000) + 1000;
    //stdout.write("Qual é o código da pizza? Informe: ");
    //var codigo = int.parse(stdin.readLineSync()!);
    stdout.write("Qual é o sabor da pizza? Informe: ");
    var sabor = stdin.readLineSync()!;
    stdout.write("Qual é o valor da pizza? Informe: ");
    var valor = double.parse(stdin.readLineSync()!);
    Pizza pizza = Pizza(codigo, sabor, valor);

    pizzaList.add(pizza);

    stdout.write("Deseja cadastrar mais uma pizza? (s/n): ");
    var maisUm = stdin.readLineSync()!;

    while (true) {
      if (maisUm == "s") {
        stdout.write("OK! Cadastre mais uma pizza. \n");
        break;
      } else if (maisUm == "n") {
        stdout.write("OK! Voltando para o menu. \n");
        repetir = false;
        break;
      } else {

        maisUm = stdin.readLineSync()!;
      }
    }
  }
}

void editarPizza(){
  print("-----------  EDITAR PIZZA  -----------");
  if(pizzaList.isEmpty){
    print("Não existe pizza cadastrada");
  } else {
    bool repetir = true;
    while(repetir){
      pizzaList.forEach((pizza) {
        print("Codigo: ${pizza.codigo}, Sabor: ${pizza.sabor}, Valor: ${pizza.valor}.");
      });

      stdout.write("Qual Pizza quer editar? informe o codigo: ");
      var codigo = int.parse(stdin.readLineSync()!);

      pizzaList.forEach((pizza) {
        if (pizza.codigo == codigo) {
          stdout.write("Qual o novo Sabor: ");
          var novoSabor = stdin.readLineSync()!;
          stdout.write("Qual o novo Valor: ");
          var novoValor = double.parse(stdin.readLineSync()!);
          pizza.sabor = novoSabor;
          pizza.valor = novoValor;
        }

      });

      stdout.write("Deseja editar mais uma pizza? (s/n): ");
      var maisUm = stdin.readLineSync()!;

      while (true) {
        if (maisUm == "s") {
          stdout.write("OK! edite mais uma pizza. \n");
          break;
        } else if (maisUm == "n") {
          stdout.write("OK! Voltando para o menu. \n");
          repetir = false;
          break;
        } else {
          stdout.write("Entrada inválida! Por favor, insira 's' para sim ou 'n' para não: ");
          maisUm = stdin.readLineSync()!;
        }
      }
    }
  }

}

void removerPizza(){
  print("---------  REMOVER PIZZA  ---------");
  if(pizzaList.isEmpty){
    print("Não existe pizza cadastrada");
  } else {
    bool repetir = true;
    while (repetir) {
      pizzaList.forEach((pizza) {
        print("Codigo: ${pizza.codigo}, Sabor: ${pizza.sabor}, Valor: ${pizza.valor}.");
      });

      stdout.write("Qual Pizza quer remover? informe o codigo: ");
      var codigo = int.parse(stdin.readLineSync()!);

      pizzaList.removeWhere((pizza) => pizza.codigo == codigo);

      stdout.write("Deseja remover mais uma pizza? (s/n): ");
      var maisUm = stdin.readLineSync()!;

      while (true) {
        if (maisUm == "s") {
          stdout.write("OK! remova mais uma pizza. \n");
          break;
        } else if (maisUm == "n") {
          stdout.write("OK! Voltando para o menu. \n");
          repetir = false;
          break;
        } else {
          stdout.write("Entrada inválida! Por favor, insira 's' para sim ou 'n' para não: ");
          maisUm = stdin.readLineSync()!;
        }
      }
    }
  }

}

void listarPizzas(){
  print("--------  PIZZAS CADASTRADAS  --------");
  if(pizzaList.isEmpty){
    print("Não existe pizza cadastrada");
  } else {
    pizzaList.forEach((pizza) {
      print("Codigo: ${pizza.codigo}, Sabor: ${pizza.sabor}, Valor: ${pizza.valor}.");
    });
  }
}

void fazerPedido(){
  if(pizzaList.isEmpty){
    print("Não existe pizza cadastrada");
  } else {
    bool repetir = true;
    while (repetir) {

      print("--------  CARDÁPIO  --------");
      pizzaList.forEach((pizza) {
        print("Codigo: ${pizza.codigo}, Sabor: ${pizza.sabor}, Valor: ${pizza.valor}.");
      });
      print("----------------------------");
      stdout.write("Faça seu pedido! \n");
      List pedidoList = [];
      while(true) {
        stdout.write("informe o codigo da pizza: ");
        var codigo = int.parse(stdin.readLineSync()!);

        if (codigo == 0) {
          print("Pedido finalizado!!");
          var random = Random();
          int codigo = random.nextInt(9000) + 1000;
          DateTime date = DateTime.now();


          double valorDoPedido = 0;
          for (int codPizzaList in pedidoList) {
            for (Pizza pizza in pizzaList) {
              if (pizza.codigo == codPizzaList) {
                valorDoPedido += pizza.valor!;
              }
            }
          }

          Pedido pedido = Pedido(codigo, date, valorDoPedido);
          pedidosList.add(pedido);
          pedidoList.forEach((codigoDaPizza) {
            pedido.adiconarPizza(codigoDaPizza);
          });
          print(pedido.emitirNota());

          break;
        } else {
          pedidoList.add(codigo);
          stdout.write("Pizza adicionada!\n");
          stdout.write("Digite 0 (zero) se quiser finalizar o pedido!\n");
        }
      }

      stdout.write("Deseja fazer mais uma pedido? (s/n): ");
      var maisUm = stdin.readLineSync()!;


      while (true) {
        if (maisUm == "s") {
          stdout.write("OK! Faça  mais uma pedido. \n");
          break;
        } else if (maisUm == "n") {
          stdout.write("OK! Voltando para o menu. \n");
          repetir = false;
          break;
        } else {
          stdout.write("Entrada inválida! Por favor, insira 's' para sim ou 'n' para não: ");
          maisUm = stdin.readLineSync()!;
        }
      }
    }
  }

}



void listarPedidos(){
  if(pizzaList.isEmpty){
    print("Não existe pizza cadastrada");
  } else {
    if(pedidosList.isEmpty){
      print("Sem pedidos!");
    } else {
      print("------------  LISTAR PEDIDOS  -----------");

      pedidosList.forEach((pedido) {
        print("____________________________________________"
            "${pedido.toString()}");
      });
    }

  }
}

void salvarDados(){
  File('Cardapio.txt').writeAsStringSync(pizzaList.map((pizza) => "${pizza.codigo}, ${pizza.sabor}, ${pizza.valor}").join('\n'));
  File('Pedidos.txt').writeAsStringSync(pedidosList.map((pedido) => "${pedido.toString()}").join('\n'));

}

void carregarDados(){
  // Lendo as frutas do arquivo .txt
  File file = File('Pedidos.txt');
  List<String> PedidosFromFile = file.readAsLinesSync();

  File file2 = File('Cardapio.txt');
  List<String> cardapioFromFile = file2.readAsLinesSync();
}





