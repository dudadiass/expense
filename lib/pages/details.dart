import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../widgets/itens.dart';


class DetalhesPage extends StatelessWidget {
  final Despesa despesa;
  const DetalhesPage({Key? key, required this.despesa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        backgroundColor: const Color(0XFF063340),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ItemDespesa(despesa: despesa),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF063340),
                ),
                onPressed: () {
                  Navigator.of(context).pop(despesa);
                },
                child: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}