import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../repository/expense.dart';

class RelatorioPage extends StatelessWidget {
  final DespesaRepository repository;
  const RelatorioPage({Key? key, required this.repository}) : super(key: key);

  Widget _itemRelatorio(String texto, double valor) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Card(
            elevation: 4.0,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$texto ${valor.toStringAsFixed(2)}")),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report"),
        backgroundColor: const Color(0XFF063340),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _itemRelatorio("Total", repository.totalDespesas),
            _itemRelatorio(
                "Last Week", repository.totalDespesasRecentes),
            _itemRelatorio(
                "Last 30 days", repository.totalDespesas30),
            _GraficoDespesas(
                dados: repository.TotalPorTipo,
                totalGeral: repository.totalDespesas),
          ],
        ),
      ),
    );
  }
}

class _GraficoDespesas extends StatelessWidget {
  final Map<TipoDespesa, double> dados;
  final double totalGeral;
  const _GraficoDespesas(
      {Key? key, required this.dados, required this.totalGeral})
      : super(key: key);

  _itemGrafico({required TipoDespesa tipo, required double totalDespesas}) {
    var porcentagem = totalDespesas / totalGeral;
    var porcentagemF = porcentagem * 100;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 30,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black87),
                  color: const Color(0xffb1c2c9)),
            ),
            FractionallySizedBox(
              widthFactor: porcentagem,
              child: Container(
                color: Colors.blue,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                  "${tipo.title} R\$${totalDespesas.toStringAsFixed(2)} (${(porcentagemF).toStringAsFixed(2)}%)"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "For a type",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ...dados.keys.map(
              (tipo) => _itemGrafico(tipo: tipo, totalDespesas: dados[tipo]!))
        ],
      ),
    );
  }
}
