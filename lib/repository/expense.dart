import 'dart:math';

import '../models/expense.dart';


class DespesaRepository {
  List<Despesa> lista = [];

  _geraAleatorias() {
    lista.clear();
    var rnd = Random();

    for (var i = 0; i < 10; ++i) {
      var id = "${rnd.nextInt(1000)}"; //gerar ids aleatorios
      var descricao = "despesa ${i + 1}";
      var data = DateTime.now().subtract(Duration(days: rnd.nextInt(10)));
      var valor = rnd.nextDouble() * 100;
      var tipo = TipoDespesa.values[rnd.nextInt(TipoDespesa.values.length)];
      var despesa = Despesa(
        id: id,
        descricao: descricao,
        data: data,
        valor: valor,
        tipo: tipo,
      );
      lista.add(despesa);
    }
  }

  DespesaRepository() {
    _geraAleatorias();
  }

  List<Despesa> _selecionaDespesasUltimosDias(int dias) {
    return lista
        .where((despesa) =>
            despesa.data.isAfter(DateTime.now().subtract(Duration(days: dias))))
        .toList();
  }

  double totalTipos({required TipoDespesa}) {
    double total = 0;

    for (var i = 0; i < lista.length; ++i) {
      if (TipoDespesa == lista[i].tipo) {
        total++;
      }
    }

    return total;
  }

  List<Despesa> get despesasRecentes {
    return _selecionaDespesasUltimosDias(7);
  }

  List<Despesa> get despesas30Dias {
    return _selecionaDespesasUltimosDias(30);
  }

  List<Despesa> despesasPorTipo(TipoDespesa tipo) {
    return lista.where((despesa) => despesa.tipo == tipo).toList();
  }

  Map<TipoDespesa, double> get TotalPorTipo {
    Map<TipoDespesa, double> mapa = {};
    TipoDespesa.values.map((tipo) {
      var sublist = despesasPorTipo(tipo);
      double total = sublist.fold<double>(
          0.0, (subtotal, despesa) => subtotal + despesa.valor);

      mapa[tipo] = total;
    }).toList();

    return mapa;
  }

  double get totalDespesas30 {
    return despesas30Dias.fold(
        0.0, (subtotal, despesa) => subtotal + despesa.valor);
  }

  double get totalDespesasRecentes {
    return despesasRecentes.fold(
        0.0, (subtotal, despesa) => subtotal + despesa.valor);
  }

  double get totalDespesas {
    double total = 0;
/*
    for (var i=0; i< lista.length; ++i){
      total += lista[i].valor;
    }

    */
/*
    for (var despesa in lista){
      total += despesa.valor;
    }

    */

    total = lista.fold<double>(
        0.0, (subtotal, despesa) => subtotal + despesa.valor);

    return total;
  }

  adiciona(
      {String? id,
      required String descricao,
      required DateTime data,
      required double valor,
      required TipoDespesa tipoDespesa}) {
    var despeesa = Despesa(
        id: id ?? "0",
        descricao: descricao,
        valor: valor,
        data: data,
        tipo: tipoDespesa);
    lista.add(despeesa);
  }

  bool remove(Despesa despesa) {
    return lista.remove(despesa);
  }
}
