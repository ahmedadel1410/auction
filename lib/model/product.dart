import 'package:firebase_database/firebase_database.dart';

class Product {
  String id='';
  String name='';
  String type='';
  int price=0;
  String image='';
  String description='';

  Product({required this.name,required this.type,required this.price,required this.image, required this.description});
  Product.map(dynamic object){
    this.id=object['id'];
    this.name=object['name'];
    this.type=object['type'];
    this.price=object['price'];
    this.image=object['image'];
    this.description=object['description'];
  }
  String get getid => id ;
  String get getname => name;
  String get gettype => type;
  int get getprice => price;
  String get getimage => image;
  String get getdescription => description;



  Product.fromSnapShot(DataSnapshot snapShot ){
    id =snapShot.key!;
    name = snapShot.value['name'] ;
    type = snapShot.value['type'] ;
    price = snapShot.value['price'] ;
    image = snapShot.value['image'] ;
    description=snapShot.value['description'];
  }
}
