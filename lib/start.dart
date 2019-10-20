import 'package:bahia_verde/data/data_carousel.dart';
import 'package:bahia_verde/tile/category_tile.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'data/data_categorys.dart';

class Start extends StatefulWidget {
  final CarouselData images;

  Start(this.images);

  @override
  _StartState createState() => _StartState(images);
}

class _StartState extends State<Start> {
  final CarouselData images;
  _StartState(this.images);

  CarouselSlider carouselSlider;
  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(180),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );
  @override
  Widget build(BuildContext context) {
    // carouselSlider = new CarouselSlider(
    //   initialPage: 0,
    //   autoPlay: true,
    //   items: images.imagens.map((url) {
    //     return Builder(builder: (BuildContext context) {
    //       return Container(
    //         margin: EdgeInsets.symmetric(horizontal: 5.0),
    //         padding: EdgeInsets.all(10.0),
    //         decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    //         height: 200,
    //         child: new Image.network(url),
    //       );
    //     });
    //   }).toList(),
    // );

    return Scaffold(
      body: Stack(alignment: Alignment.topCenter, children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                  height: 200,
                  padding: EdgeInsets.only(bottom: 10),
                  child: new Carousel(
                    boxFit: BoxFit.cover,
                    images: images.imagens.map((url) {
                      return NetworkImage(url);
                    }).toList(),
                    showIndicator: true,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(seconds: 1),
                    autoplayDuration: Duration(seconds: 3),
                    autoplay: true,
                    dotSize: 4.0,
                    dotSpacing: 15.5,
                    dotBgColor: Colors.transparent,
                    dotColor: Theme.of(context).primaryColor,
                    moveIndicatorFromBottom: 2,
                  )),
            ),
            SliverToBoxAdapter(
                child: Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        horizontalLine(),
                        Text(
                          "Produtos",
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                        horizontalLine()
                      ],
                    ))),
            FutureBuilder<QuerySnapshot>(
                future:
                    Firestore.instance.collection('produtos').getDocuments(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  return SliverGrid.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 0.65,
                    children: snapshot.data.documents.map((doc) {
                      return CategoryTile(CategoryData.formDocument(doc));
                    }).toList(),
                  );
                  // SliverToBoxAdapter(
                  //     //padding: EdgeInsets.only(top: 200),
                  //     child: new GridView.builder(
                  //   padding: EdgeInsets.all(10),
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       mainAxisSpacing: 4.0,
                  //       crossAxisSpacing: 4.0,
                  //       childAspectRatio: 0.65),
                  //   itemCount: snapshot.data.documents.length,
                  //   itemBuilder: (context, index) {
                  //     return CategoryTile(CategoryData.formDocument(
                  //         snapshot.data.documents[index]));
                  //   },
                  // ));
                }),
          ],
        ),
        // Container(
        //     height: 200,
        //     child: new Carousel(
        //       boxFit: BoxFit.cover,
        //       images: images.imagens.map((url) {
        //         return NetworkImage(url);
        //       }).toList(),
        //       showIndicator: true,
        //       animationCurve: Curves.fastOutSlowIn,
        //       animationDuration: Duration(seconds: 1),
        //       autoplayDuration: Duration(seconds: 3),
        //       autoplay: true,
        //       dotSize: 4.0,
        //       dotSpacing: 15.5,
        //       dotBgColor: Colors.transparent,
        //       dotColor: Colors.white,
        //       moveIndicatorFromBottom: 2,
        //     )),
        // CategoryScreen(),
      ]),
    );
  }
}
