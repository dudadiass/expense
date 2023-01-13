enum TipoDespesa { alimento, lazer, transporte, servicos, outros }

extension TipoDespesaExtension on TipoDespesa{

  String get title {

    switch (this){
      case TipoDespesa.alimento:
      return "food";
      case TipoDespesa.lazer:
      return "Recreation";
      case TipoDespesa.servicos:
      return "Services";
      case TipoDespesa.transporte: 
      return "Transport";
      case TipoDespesa.outros:
      return "others";
      
    }
  }
}

class Despesa {
  final String id;
  final String descricao;
  final double valor;
  final DateTime data;
  final TipoDespesa tipo;

  Despesa(
      {required this.id,
      required this.descricao,
      required this.valor,
      required this.data,
      required this.tipo});
}