import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

class DespesaForm extends StatefulWidget {
  final Function adiciona;
  const DespesaForm({Key? key, required this.adiciona}) : super(key: key);

  @override
  State<DespesaForm> createState() => _DespesaFormState();
}

class _DespesaFormState extends State<DespesaForm> {
  final _descricaoInput = TextEditingController();
  final _valorInput = TextEditingController();
  TipoDespesa _tipoDespesa = TipoDespesa.outros;
  DateTime _data = DateTime.now();

  _selecionarData() {
    showDatePicker(
            context: context,
            initialDate: _data,
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((dataSelecionada) {
      if (dataSelecionada != null) {
        setState(() {
          _data = dataSelecionada;
        });
      }
    });
  }

  _submit() {
    final descricao = _descricaoInput.text;
    final double valor = double.parse(_valorInput.text);

    widget.adiciona(
        valor: valor,
        descricao: descricao,
        data: _data,
        tipoDespesa: _tipoDespesa);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              const Text("Type: ", style: TextStyle(fontSize: 17)),
              DropdownButton<TipoDespesa>(
                value: _tipoDespesa,
                underline: Container(
                  color: Theme.of(context).primaryColor,
                  height: 2.0,
                ),
                items: TipoDespesa.values
                    .map((tipo) => DropdownMenuItem<TipoDespesa>(
                          value: tipo,
                          child: Text(tipo.title),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    _tipoDespesa = newValue ?? TipoDespesa.outros;
                  });
                },
              ),
            ],
          ),
          TextField(
              controller: _descricaoInput,
              decoration: const InputDecoration(
                label: Text("Description"),
              ),
              onSubmitted: (value) {
              }),
          const SizedBox(height: 10),
          TextField(
            controller: _valorInput,
            keyboardType: TextInputType.number, //apenas opcoes de numeros
            decoration: const InputDecoration(
              label: Text("Value (R\$)"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  "Expense date: ${DateFormat("dd/MM/yyyy").format(_data)}",
                  style: const TextStyle(fontSize: 17.00),
                ),
              ),
              TextButton(
                onPressed: () {
                  _selecionarData();
                },
                child: const Icon(
                  Icons.calendar_today,
                  color: Color(0XFF063340),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0XFF063340),
            ),
            onPressed: () {
              _submit();
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
