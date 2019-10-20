import 'package:bahia_verde/data/data_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartProduct {
  String cid;
  String category;
  String pid;

  int quantity;

  String tipo;

  ProductData productData;
  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    category = document.data['categoria'];
    pid = document.data['produto_id'];
    quantity = document.data['quantidade'];
  }

  Map<String, dynamic> toMap() {
    return {
      "categoria": category,
      "produto_id": pid,
      "quantidade": quantity,
      "tipo": tipo,
      //"produto": productData.toResumedMap()
    };
  }
}
