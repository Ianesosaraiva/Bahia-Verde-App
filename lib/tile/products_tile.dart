import 'package:bahia_verde/data/data_products.dart';
import 'package:bahia_verde/products/product.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final ProductData data;

  ProductTile(this.data);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: AspectRatio(
                  aspectRatio: 0.80,
                  child: Image.network(
                    data.imagens[0],
                    fit: BoxFit.cover,
                  )),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      data.titulo,
                      style: TextStyle(color: Theme.of(context).accentColor,),
                    ),
                    Text(
                      "A partir de R\$ ${data.preco.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Product(data)));
      },
    );
  }
}
