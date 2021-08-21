import 'dart:async';
import 'package:auction/model/auction.dart';
import 'package:auction/model/product.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class adminController extends ChangeNotifier{
  final productrefrence = FirebaseDatabase.instance.reference().child('product');
  final auctionrefrence = FirebaseDatabase.instance.reference().child('auction');
  final offersReference = FirebaseDatabase.instance.reference().child('offers');
  Timer? timer;
  String errorAddingProduct='';
  Event? event;
  addproduct(String name, String type,int price, String image,String description)async{
     await productrefrence.push().set({
        'name':name,
        'type':type,
        'price':price,
        'image':image,
       'description':description
      },
      ).then((value) {
       errorAddingProduct='successfully added';
     }).catchError((e){
       errorAddingProduct='something go wrong';
     });

  }
  updateProduct(String id,String name, String type,int price, String image,String description)async{
   await productrefrence.child(id).set({
      'name':name,
      'type':type,
      'price':price,
      'image':image,
     'description':description
    }).then((value) {
     errorAddingProduct='successfully Updated';
   }).catchError((e){
     errorAddingProduct='something go wrong';
   });

  }
  deleteproduct(String id)async{
    await productrefrence.child(id).remove();
  }
  addAuction(Product product,int startPrice)async{
    await auctionrefrence.push().set({
      'state':'off',
      'soldPrice':0,
      'timer':0,
      'startPrice':startPrice,
      'name':product.name,
      'type':product.type,
      'price':product.price,
      'image':product.image,
      'winner':''
    });
  }

  startauction(Auction auction)async{
    auctionrefrence.child(auction.id).set({
      'state':'inprogress',
      'soldPrice':0,
      'timer':auction.timer,
      'startPrice':auction.auctionStatrtPrice,
      'name':auction.product.name,
      'type':auction.product.type,
      'price':auction.product.price,
      'image':auction.product.image,
      'winner':''
      });
    //upadte timer
    //update state in progress
    //startcountdown
  }
  finishAuction(Auction auction)async{
    auctionrefrence.child(auction.id).set({
      'state':'finished',
      'soldPrice':auction.soldPrice,
      'timer':auction.timer,
      'startPrice':auction.auctionStatrtPrice,
      'name':auction.product.name,
      'type':auction.product.type,
      'price':auction.product.price,
      'image':auction.product.image,
      'winner':auction.winner
    });

  }
  starttimer(Auction auction){
    Timer.periodic(Duration(minutes:1 ), (timer) async {
      auction.timer--;
      await startauction(auction);
      if(auction.timer==0) {
        timer.cancel();
        await  finishAuction(auction);
      }
    });

  }
  deleteauction(String id)async{
    await auctionrefrence.child(id).remove();
  }

}