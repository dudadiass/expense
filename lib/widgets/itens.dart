import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';


class ItemDespesa extends StatelessWidget {
  final Despesa despesa;

  const ItemDespesa({
    Key? key,
    required this.despesa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
//-------------------------------------------------------
            Container(
              width: 150,
              color: const Color(0XFF8f3636),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  // Image.asset("images/transporte.png", width: 30, height: 20 ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                    child: Text(
                      despesa.descricao,
                      style:
                          const TextStyle(fontSize: 17.0, color: Colors.white),
                    ),
                  ),
                  Text(despesa.tipo.title,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12.0)),
                  Text(DateFormat("dd/MM/yyyy").format(despesa.data),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12.0)),
                ],
              ),
            ),

            // ----------------------------------------------------------
            Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(9.0)),
                child: Text("R\$ ${despesa.valor.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 17.0, fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
}