class ContatoModel {
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String nome = "";
  String telefone = "";
  String? imagePath;

  ContatoModel({required this.nome, required this.telefone, this.imagePath});

  ContatoModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    nome = json['nome'];
    telefone = json['telefone'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['nome'] = nome;
    data['telefone'] = telefone;
    data['image_path'] = imagePath;
    return data;
  }

  Map<String, dynamic> toJsonEndPoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['telefone'] = telefone;
    data['image_path'] = imagePath;
    return data;
  }
}
