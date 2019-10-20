import 'package:cloud_firestore/cloud_firestore.dart';

class CarouselData {
  String id;
  String category;

  List imagens;

  CarouselData.formDcument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    category = snapshot.data['category'];
    imagens = snapshot.data['imagens'];
  }
}
