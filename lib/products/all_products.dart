import 'package:bahia_verde/data/data_categorys.dart';
import 'package:bahia_verde/list_pages/list_products.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final CategoryData data;

  Products(this.data);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(data.titulo),
          centerTitle: true,
        ),
        body: ProductsScreen(this.data)
    );
  }
}