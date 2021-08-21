import 'package:auction/model/product.dart';
import 'package:firebase_database/firebase_database.dart';

class Auction{
  String id='';
  Product product =new Product(name: '', type: '', price: 0, image:'',description: '');
  int auctionStatrtPrice=0;
  String winner='';
 String auctionState='';
 int soldPrice=0;
 int timer=0;
 Auction({required this.product,required this.auctionState,required this.auctionStatrtPrice});
 Auction.map(dynamic object){
 this.id=object['id'];
 this.product.name=object['name'];
 this.product.type=object['type'];
 this.product.price=object['price'];
 this.product.image=object['image'];
 this.auctionState=object['state'];
 this.auctionStatrtPrice=object['startPrice'];
 this.soldPrice=object['soldPrice'];
 this.timer=object['timer'];
 this.winner=object['winner'];


 }
  String get getid => id;
 String get getproductname => product.name;
  String get getproducttype => product.type;
  int get getproductprice => product.price;
  String get getproductimage => product.image;
  String get getstate => auctionState;
  int get getstartprice => auctionStatrtPrice;
  int get getsoldprice => soldPrice;
  int get gettimer => timer;
  String get getwinner => winner;

  Auction.snapshot(DataSnapshot snapshot){
   this.id=snapshot.key!;
   this.product.name=snapshot.value['name'];
   this.product.type=snapshot.value['type'];
   this.product.price=snapshot.value['price'];
   this.product.image=snapshot.value['image'];
   this.auctionState=snapshot.value['state'];
   this.auctionStatrtPrice=snapshot.value['startPrice'];
   this.soldPrice=snapshot.value['soldPrice'];
   this.timer=snapshot.value['timer'];
   this.winner=snapshot.value['winner'];

  }
}