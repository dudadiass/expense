import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../widgets/details_itens.dart';
import '../widgets/form.dart';
import 'details.dart';
import 'report.dart';
import '../repository/expense.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DespesaRepository _repository = DespesaRepository();
  final ScrollController _scrollController = ScrollController();

  _adicionaDespesa(
      {String? id,
      required String descricao,
      required DateTime data,
      required double valor,
      required TipoDespesa tipoDespesa}) {
    setState(() {
      _repository.adiciona(
          id: id,
          descricao: descricao,
          data: data,
          valor: valor,
          tipoDespesa: tipoDespesa);
    });
  }

  _showDespesaForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return DespesaForm(adiciona: _adicionaDespesa);
      },
    );
  }

  _mostraDetalhes(Despesa despesa) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return DetalhesPage(despesa: despesa);
      },
    )).then((despesa) {
      if (despesa != null) {
        setState(() {
          _repository.remove(despesa);
        });
      }
    });
  }

  _mostraRelatorio() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return RelatorioPage(repository: _repository);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expenses",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _mostraRelatorio();
            },
            icon: const Icon(Icons.details),
            color: Colors.white,
          ),
        ],
        backgroundColor: const Color(0XFF063340),
      ),
      body: Scrollbar(
        thickness: 8.0,
        interactive: true,
        controller: _scrollController,
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            var despesa = _repository.lista[index];
            return ItemDespesaClicavel(
              despesa: despesa,
              mostraDetalhes: _mostraDetalhes,
            );
          },
          itemCount: _repository.lista.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0XFF063340),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () {
          _showDespesaForm(context);
        },
      ),
    );
  }
}
