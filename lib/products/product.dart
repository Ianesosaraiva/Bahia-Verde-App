import 'package:bahia_verde/Actions/carrinho.dart';
import 'package:bahia_verde/Autentication/login.dart';
import 'package:bahia_verde/data/data_cart_pedidos.dart';
import 'package:bahia_verde/data/data_products.dart';
import 'package:bahia_verde/model/auth_model.dart';
import 'package:bahia_verde/model/cart_model.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  final ProductData product;

  String tipo;
  num preco;
  bool opcional = false;
  FilterChipWidget fcw = new FilterChipWidget();

  // double caulculo(double p) {
  //   this.preco = p;
  // }

  Product(this.product);

  static Iterable get all => null;
  @override
  _ProductState createState() => _ProductState(product, tipo, preco, opcional);
}

class _ProductState extends State<Product> {
  final ProductData product;

  String tipo;
  num preco;
  bool opcional = false;
  _ProductState(this.product, this.tipo, this.preco, this.opcional);
  var _selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.titulo),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: Border.all(color: Colors.white, width: 5.0)),
                child: Carousel(
                  images: product.imagens.map((url) {
                    return NetworkImage(url);
                  }).toList(),
                  dotSize: 4.0,
                  dotSpacing: 15.0,
                  dotBgColor: Colors.transparent,
                  dotColor: Theme.of(context).accentColor,
                  autoplay: false,
                ),
              )),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.titulo,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  this.preco == null
                      ? "R\$ ${product.preco.toStringAsFixed(2)}"
                      : "R\$ ${this.preco.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Divider(
                  height: 20,
                ),
                Text(
                  "Tipos",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 65,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.5),
                    children: product.tipos.map((t) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            this.tipo = t['titulo'];
                            this.preco = t['preco'];
                            this.opcional = t['opcional'];
                            if (opcional) {
                              this.preco += this.product.preco;
                            }
                          });
                        },
                        child: this.product.opcional
                            ? FilterChipWidget(
                                produtc: product,
                                tipo: t,
                                chipName: t['titulo'] +
                                    "\n" +
                                    "R\$ ${t['preco'].toStringAsFixed(2)}")
                            // ? ListTile(
                            //     selected: _selected,
                            //     title: new Text("Test"),
                            //     subtitle: new Text("Test Desc"),
                            //     trailing: new Text("3"),
                            //     onLongPress: () {
                            //       setState(() {
                            //         if (_selected) {
                            //           this.preco += t['preco'];
                            //         }
                            //       });
                            //     } // what should I put here,
                            //     )
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: t['titulo'] == this.tipo
                                            ? Theme.of(context).accentColor
                                            : Colors.grey[500],
                                        width: 3.0)),
                                width: 50.0,
                                height: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  t['titulo'] +
                                      "\n" +
                                      "R\$ ${t['preco'].toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 4,
                                ),
                              ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: tipo != null
                        ? () {
                            if (UserModel.of(context).isLoggedIn()) {
                              CartProduct cartProduct = new CartProduct();
                              cartProduct.pid = product.id;
                              cartProduct.quantity = 1;
                              cartProduct.tipo = tipo;
                              cartProduct.category = product.categoria;

                              CartModel.of(context).addCartItem(cartProduct);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Carrinho()));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Login()));
                            }
                          }
                        : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn()
                          ? "Fazer Pedido"
                          : "Entrer para Comprar",
                      style: TextStyle(fontSize: 16),
                    ),
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Descrição",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  product.descricao,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final Map tipo;
  final ProductData produtc;
  num preco;

  FilterChipWidget({Key key, this.chipName, this.tipo, this.produtc})
      : super(key: key);

  @override
  _FilterChipWidgetState createState() =>
      _FilterChipWidgetState(tipo, produtc, preco);
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  final Map tipo;
  final ProductData product;
  final num preco;

  _FilterChipWidgetState(this.tipo, this.product, this.preco);

  Product p;

  String tipos;
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        widget.chipName,
        textAlign: TextAlign.center,
        maxLines: 4,
      ),
      labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16.0,
          fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      backgroundColor: Color(0xffd32f2f),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          if (_isSelected) {
            if (this.tipo['opcional']) {
              //widget.preco += tipo['preco'];
            }
          }
        });
      },
      selectedColor: Theme.of(context).accentColor,
    );
  }
}
