import 'package:listacontatos/model/contato_model.dart';

class Back4appRepositoryModel {
  List<ContatoModel>? contatos;

  Back4appRepositoryModel({this.contatos});

  Back4appRepositoryModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      contatos = <ContatoModel>[];
      json['results'].forEach((v) {
        contatos!.add(ContatoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contatos != null) {
      data['results'] = contatos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
