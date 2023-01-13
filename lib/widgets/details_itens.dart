import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'itens.dart';

class ItemDespesaClicavel extends StatelessWidget {
  final Despesa despesa;
  final Function mostraDetalhes;
  const ItemDespesaClicavel(
      {Key? key, required this.despesa, required this.mostraDetalhes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          mostraDetalhes(despesa);
        },
        child: ItemDespesa(despesa: despesa));
  }
}
