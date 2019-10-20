import 'package:bahia_verde/data/data_categorys.dart';
import 'package:bahia_verde/data/data_products.dart';
import 'package:bahia_verde/tile/products_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  final CategoryData data;

  ProductsScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection('produtos')
            .document(data.id)
            .collection('itens')
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Container(
              padding: EdgeInsets.only(top: 20),
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 0.65),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  ProductData data =
                      ProductData.formDocument(snapshot.data.documents[index]);
                  data.categoria = this.data.id;
                  return ProductTile(data);
                },
              ));
        });
  }
}
