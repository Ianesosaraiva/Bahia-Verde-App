import 'package:bahia_verde/data/data_categorys.dart';
import 'package:bahia_verde/products/all_products.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final CategoryData data;

  CategoryTile(this.data);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
                aspectRatio: 0.80,
                child: Image.network(
                  data.imagem,
                  fit: BoxFit.cover,
                )),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      data.titulo,
                      style: TextStyle(color: Theme.of(context).accentColor, fontSize: 13),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Products(this.data)));
      },
    );
  }
}
