import 'package:firebase_database/firebase_database.dart';

class Offer{
 String id='';
 int price=0;
 String email='';
 Offer({required this.email,required this.price});

 Offer.map(Map <String,dynamic> object){
  this.id=object['id'];
  this.email=object['email'];
  this.price=object['price'];
 }

 String get getid => id ;
 String get getemail =>email;
 int get getprice => price;

 Offer.snapshot(DataSnapshot snapshot){
  id=snapshot.key!;
 email =snapshot.value['email'];
 price =snapshot.value['price'];
 }


}