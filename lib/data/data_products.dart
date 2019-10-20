import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String categoria;
  String id;
  String titulo;
  String descricao;

  bool opcional;

  num preco;

  List imagens;
  List tipos;

  ProductData.formDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    titulo = snapshot.data['titulo'];
    descricao = snapshot.data['descricao'];

    opcional = snapshot.data['opcional'];
    
    preco = snapshot.data['preco'];

    imagens = snapshot.data['imagens'];
    tipos = snapshot.data['tipos'];
  }
}
