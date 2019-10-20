import 'package:bahia_verde/data/data_categorys.dart';
import 'package:bahia_verde/tile/category_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListCategory extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ListCategory(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 0.65),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        return CategoryTile(CategoryData.formDocument(snapshot.data[index]));
      },
    );
  }
}
