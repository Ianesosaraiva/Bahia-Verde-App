import 'package:bahia_verde/data/data_categorys.dart';
import 'package:bahia_verde/tile/category_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  @override
  CategoryScreenState createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('produtos').getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          return new Container(
              padding: EdgeInsets.only(top: 200),
              child: new GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 0.65),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return CategoryTile(CategoryData.formDocument(
                      snapshot.data.documents[index]));
                },
              ));
        });
  }
}
