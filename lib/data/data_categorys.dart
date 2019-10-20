import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryData {
  String id;
  String titulo;

  String imagem;

  CategoryData.formDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    titulo = snapshot.data['titulo'];
    imagem = snapshot.data['imagem'];
  }
}
