import 'dart:io';
import 'Banco.dart';
import 'Conta.dart';
import 'Titular.dart';

Banco banco = Banco("Dart Bank"); //criando banco
Titular titular = Titular("teste");
void main() {
  print("Acessando ${banco.nomeBanco} !");

  //adm teste
  Titular titularPadrao = Titular("Admin");
  banco.adicionarTitular(titularPadrao);
  Conta contaPadrao = Conta("Boletos agua", 3413114, titularPadrao);
  Conta contaPadrao2 = Conta("Boletos luz", 32342, titularPadrao);
  Conta contaPadrao3 = Conta("Boletos net", 34145134, titularPadrao);
  banco.adicionarConta(contaPadrao);
  banco.adicionarConta(contaPadrao2);
  banco.adicionarConta(contaPadrao3);
  banco.depositar(10, 1);
  banco.depositar(10, 2);
  banco.depositar(10, 3);

  menuPrincipal();
}

void menuPrincipal() {
  bool sair = false;
  while (!sair) {
    print("*** MENU PRINCIPAL ***");
    print("1. Cadastro de Titular");
    print("2. Cadastro de Conta");
    print("3. Operar conta");
    print("4. Sair");
    stdout.write("Escolha uma opção: ");

    String? escolha = stdin.readLineSync();

    if (escolha != null) {
      switch (escolha) {
        case "1":
          subMenuCadastroTitular();
          break;
        case "2":
          subMenuCadastroConta();
          break;
        case "3":
          subMenuOperarConta();
          break;
        case "4":
          print("Encerrando programa!");
          sair = true;
          break;
        default:
          print("Opção inválida. Tente novamente.");
          break;
      }
    }
  }
}

void subMenuCadastroTitular() {
  print("Cadastro de Titular - VEJA O MENU:");

  bool sairCadTitular = false;
  while (!sairCadTitular) {
    print("1. Cadastrar um Titular");
    print("2. Ler um Titular");
    print("3. Editar um Titular");
    print("4. Deletar um Titular");
    print("5. Voltar ao MENU PRICIPAL");
    stdout.write("Escolha uma opção: ");

    String? escolha = stdin.readLineSync();

    if (escolha != null) {
      switch (escolha) {
        case "1":
          stdout.write("*** CADASTRAR UM TITULAR ***\n");
          while (true) {
            //cadastrando um titular
            stdout.write("Para cadastrar informe o nome: ");
            String? nomeTitular = stdin.readLineSync() ?? "";
            Titular titular = Titular(nomeTitular);
            banco.adicionarTitular(titular);
            //adiconar mais um?
            stdout.write("Cadastrar mais um? s/n: ");
            String maisUm = stdin.readLineSync() ?? "";
            if (maisUm != "s") {
              break;
              //sai do while
            }
          }
          break;
        case "2":
          stdout.write("*** LER UM TITULAR ***\n");
          //lendo titulares de banco
          if (banco.getTitulares == null || banco.getTitulares!.isEmpty) {
            print("O banco não possui titulares.");
          } else {
            print(banco);
          }
          break;
        case "3":
          stdout.write("*** EDITAR UM TITULAR ***\n");
          while (true) {
            print("Veja a lista de titulares:");
            print(banco);

            stdout.write("Para editar digite o ID correspondente ao titular: ");
            String idParaEditar = stdin.readLineSync() ?? "";
            int idConvertido = int.parse(idParaEditar);
            stdout.write("Qual o Novo nome do Titular? Informe: ");
            String novoNome = stdin.readLineSync() ?? "";
            banco.editarTitular(idConvertido, novoNome);

            stdout.write("Editar mais um? s/n: ");
            String maisUm = stdin.readLineSync() ?? "";
            if (maisUm != "s") {
              break;
              //sai do while
            }
          }
          break;
        case "4":
          stdout.write("*** DELETAR UM TITULAR ***\n");
          print("Veja a lista de titulares:");
          print(banco);

          stdout.write("Para deletar digite o ID correspondente ao titular: ");
          String idParaDeletar = stdin.readLineSync() ?? "";
          int idConvertido = int.parse(idParaDeletar);

          banco.deletarTitular(idConvertido);

          stdout.write("Editar mais um? s/n: ");
          String maisUm = stdin.readLineSync() ?? "";
          if (maisUm != "s") {
            break;
            //sai do while
          }
          break;
        case "5":
          sairCadTitular = true;
          break;
        default:
          print("Opção inválida. Tente novamente.");
          break;
      }
    }
  }
}

void subMenuCadastroConta() {
  print("Cadastro de Conta - VEJA O MENU:");

  bool sairCadConta = false;
  while (!sairCadConta) {
    print("1. Cadastrar uma Conta");
    print("2. Ler uma Conta");
    print("3. Editar uma Conta");
    print("4. Deletar uma Conta");
    print("5. Voltar ao MENU PRICIPAL");
    stdout.write("Escolha uma opção: ");

    String? escolha = stdin.readLineSync();

    if (escolha != null) {
      switch (escolha) {
        case "1":
          stdout.write("*** CADASTRAR UMA CONTA ***\n");
          while (true) {
            stdout.write("Lista de Titulares:\n");

            List<Titular>? titulares = banco.getTitulares;
            for (Titular titular in titulares!) {
              print("ID: ${titular.getId} Nome: ${titular.getNome} ");
            }

            stdout.write(
                "Escolha um titular para adicionar uma conta, informe ID correspondente: ");
            String? IdDoTitularString = stdin.readLineSync() ?? "";
            int IdDoTitular = int.parse(IdDoTitularString);

            for (Titular titular in titulares) {
              if (titular.getId == IdDoTitular) {
                //cadastrando uma conta para o titular escolhido
                while (true) {
                  print(
                      "Cadastrando uma conta para o titular ( ${titular.getNome} )");
                  stdout.write(
                      "Para cadastrar informe uma descricao ( ex:Conta dos boletos): ");
                  String? descricaoDaConta = stdin.readLineSync() ?? "";
                  stdout.write(
                      "Para cadastrar informe o numero da conta ( ex:1212 ): ");
                  String? numeroDaContaString = stdin.readLineSync() ?? "";
                  int numeroDaConta = int.parse(numeroDaContaString);

                  Conta conta = Conta(descricaoDaConta, numeroDaConta, titular);
                  titular.adicionarConta(conta);
                  banco.adicionarConta(conta);
                  //print(conta.toString());
                  print(titular.toString());
                  stdout.write("Cadastrar mais uma? s/n: ");
                  String maisUm = stdin.readLineSync() ?? "";
                  if (maisUm != "s") {
                    break;
                    //sai do while
                  }
                }
              }
            }
            stdout.write("Cadastrar mais uma conta? s/n: ");
            String maisUm = stdin.readLineSync() ?? "";
            if (maisUm != "s") {
              break;
              //sai do while
            }
          }
        case "2":
          stdout.write("*** LER UMA CONTA ***\n");
          //lendo contas do banco
          if (banco.getContas == null || banco.getContas!.isEmpty) {
            print("O banco não possui contas.");
          } else {
            List<Conta> contasList = banco.getContas!;
            for (Conta conta in contasList) {
              print(
                  "ID: ${conta.getId}, Descrição: ${conta.getDescricao}, Conta: ${conta.getNumeroConta}, "
                  "Saldo: ${conta.getSaldo}.");
            }
          }
          break;
        case "3":
          stdout.write("*** EDITAR UMA CONTA ***\n");
          while (true) {
            print("Veja a lista de contas:");
            List<Conta> contasList = banco.getContas!;
            for (Conta conta in contasList) {
              print(
                  "ID: ${conta.getId}, Descrição: ${conta.getDescricao}, Conta: ${conta.getNumeroConta}, "
                  "Saldo: ${conta.getSaldo}.");
            }

            stdout.write("Para editar digite o ID correspondente a conta: ");
            String idParaEditarString = stdin.readLineSync() ?? "";
            int idParaEditar = int.parse(idParaEditarString);
            stdout.write("Qual a nova descrição da conta? Informe: ");
            String novaDescricao = stdin.readLineSync() ?? "";

            banco.editarConta(idParaEditar, novaDescricao);

            stdout.write("Editar mais um? s/n: ");
            String maisUm = stdin.readLineSync() ?? "";
            if (maisUm != "s") {
              break;
              //sai do while
            }
          }
          break;
        case "4":
          while (true) {
            stdout.write("*** DELETAR UMA CONTA ***\n");
            print("Veja a lista de contas:");
            List<Conta> contasList = banco.getContas!;
            for (Conta conta in contasList) {
              print(
                  "ID: ${conta.getId}, Descrição: ${conta.getDescricao}, Conta: ${conta.getNumeroConta}, "
                  "Saldo: ${conta.getSaldo}.");
            }

            stdout.write("Para deletar digite o ID correspondente a conta: ");
            String idParaDeletarString = stdin.readLineSync() ?? "";
            int idParaDeletar = int.parse(idParaDeletarString);

            banco.deletarContar(idParaDeletar);

            stdout.write("Editar mais um? s/n: ");
            String maisUm = stdin.readLineSync() ?? "";
            if (maisUm != "s") {
              break;
              //sai do while
            }
          }
          break;
        case "5":
          sairCadConta = true;
          break;
        default:
          print("Opção inválida. Tente novamente.");
          break;
      }
    }
  }
}

void subMenuOperarConta() {
  print("*** OPERAR CONTA ***");

  print("Veja a lista de contas: ");
  List<Conta> contasList = banco.getContas!;
  for (Conta conta in contasList) {
    print(
        "ID: ${conta.getId}, Descrição: ${conta.getDescricao}, Conta: ${conta.getNumeroConta}, "
        "Saldo: ${conta.getSaldo}.");
  }

  stdout.write("Para operar uma conta digite o ID correspondente a conta: ");
  String idParaOperarString = stdin.readLineSync() ?? "";
  int idParaOperar = int.parse(idParaOperarString);

  bool sairOperaConta = false;
  while (!sairOperaConta) {
    print("1. Sacar");
    print("2. Depositar");
    print("3. Transferir");
    print("4. Exibir saldo");
    print("5. Voltar ao MENU PRICIPAL");
    stdout.write("Escolha uma opção: ");

    String? escolha = stdin.readLineSync();

    if (escolha != null) {
      switch (escolha) {
        case "1":
          while (true) {
            stdout.write("Para sacar informe um valor: ");

            String? saqueString = stdin.readLineSync() ?? "";
            double valorSaque = double.parse(saqueString);

            var saque = banco.sacar(valorSaque, idParaOperar);

            if (saque) {
              print("saque bem sucedido");
            } else {
              print("Operação invalida, verifique o saldo");
            }

            stdout.write("Fazer mais um? s/n: ");
            String maisUm = stdin.readLineSync() ?? "";

            if (maisUm != "s") {
              break;
              //sai do while
            }
          }
          break;
        case "2":
          while (true) {
            stdout.write("Para depositar informe um valor: ");

            String? depositoString = stdin.readLineSync() ?? "";
            double depositoSaque = double.parse(depositoString);

            var deposito = banco.depositar(depositoSaque, idParaOperar);

            if (deposito) {
              print("deposito bem sucedido");
            } else {
              print("Operação invalida, valor invalido para deposito");
            }
            stdout.write("Fazer mais um? s/n: ");
            String maisUm = stdin.readLineSync() ?? "";
            if (maisUm != "s") {
              break;
              //sai do while
            }
          }
          break;
        case "3":
          while (true) {
            stdout.write("Qual valor para tranferir? informe: ");
            String valorTrasferidoString = stdin.readLineSync() ?? "";
            double valortranferido = double.parse(valorTrasferidoString);

            print("Veja a lista de contas");
            List<Conta> contasList = banco.getContas!;
            for (Conta conta in contasList) {
              print(
                  "ID: ${conta.getId}, Descrição: ${conta.getDescricao}, Conta: ${conta.getNumeroConta}.");
            }
            stdout.write(
                "Para qual conta deseja trasferir, informe ID correspondente: ");
            String idParaTranferirString = stdin.readLineSync() ?? "";
            int idParaTranferir = int.parse(idParaTranferirString);

            var transferencia = banco.transferirSaldo(
                valortranferido, idParaOperar, idParaTranferir);

            if (transferencia) {
              print(
                  "Trasferencia feita com suceso, verifique o saldo da conta");
            } else {
              print("Operação invalida, verifique o valor da transferencia");
            }

            stdout.write("fazer mais uma trasferencia? s/n: ");
            String maisUm = stdin.readLineSync() ?? "";
            if (maisUm != "s") {
              break;
              //sai do while
            }
          }
          break;
        case "4":
          print("O saldo da conta é: ${banco.exibirSaldo(idParaOperar)}");
          break;
        case "5":
          sairOperaConta = true;
          break;
        default:
          print("Opção inválida. Tente novamente.");
          break;
      }
    }
  }
}
