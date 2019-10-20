import 'package:bahia_verde/data/data_products.dart';
import 'package:flutter/material.dart';

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final Map tipo;
  final ProductData produtc;

  FilterChipWidget({Key key, this.chipName, this.tipo, this.produtc})
      : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState(tipo, produtc);
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  final Map tipo;
  final ProductData product;

  _FilterChipWidgetState(this.tipo, this.product);

  String tipos;
  num preco;
  bool opcional = false;
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
          color: Colors.green[900],
          fontSize: 16.0,
          fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      backgroundColor: Color(0xffededed),      
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          this.tipos = tipo['titulo'];
          this.preco = tipo['preco'];
          this.opcional = tipo['opcional'];
          if (opcional) {
            this.preco += this.product.preco;
          }
          
        });
      },
      selectedColor: Colors.greenAccent,
    );
  }
}
