import 'package:listacontatos/model/contato_model.dart';
import 'package:listacontatos/repository/back4app_repository_model.dart';
import 'package:listacontatos/repository/configuracao_dio.dart';

class Back4appRepository {
  final _customDio = Back4AppCustomDio();

  Back4appRepository();

  Future<Back4appRepositoryModel> obterContatos() async {
    var url = "/Contatos";
    var result = await _customDio.dio.get(url);
    var resultbody = result.data;
    return Back4appRepositoryModel.fromJson(resultbody);
  }

  Future<void> criar(ContatoModel contatomodel) async {
    try {
      await _customDio.dio.post("/Contatos", data: contatomodel.toJsonEndPoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> atualizar(ContatoModel contatomodel) async {
    try {
      var response = await _customDio.dio.put("/Contatos/${contatomodel.objectId}", data: contatomodel.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      var response = await _customDio.dio.delete(
        "/Contatos/$objectId",
      );
    } catch (response) {
      throw response;
    }
  }

  List<ContatoModel> jsonToList(var lista) {
    List<ContatoModel> listamodel = <ContatoModel>[];

    if (lista != null) {
      for (Map<String, dynamic> item in lista) {
        listamodel.add(ContatoModel.fromJson(item));
      }
    }
    return listamodel;
  }
}
