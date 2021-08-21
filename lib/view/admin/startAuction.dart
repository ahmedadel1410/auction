import 'dart:async';

import 'package:auction/controller/Utility.dart';
import 'package:auction/controller/admincontroller.dart';
import 'package:auction/controller/dbcontroller.dart';
import 'package:auction/model/auction.dart';
import 'package:auction/model/offer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class startAuction extends StatefulWidget{
  final Auction auction;
  startAuction(this.auction);
  @override
  State<StatefulWidget> createState() {

    return startAuctionState();
  }

}
class startAuctionState extends State <startAuction>{
  adminController admindb = new adminController();
  dbController db= new dbController();
 TextEditingController timercontroller = new TextEditingController();
  final dbReference = FirebaseDatabase.instance.reference().child('auction');
  String error='';
 late Auction auction ;
  late StreamSubscription<Event> onauctionUpdated;
  final offersrefrence = FirebaseDatabase.instance.reference().child('offers').orderByChild('price').limitToLast(1);
  Offer bestOffer=new Offer(email: '', price: 0);
  late StreamSubscription<Event>  onofferadded ;

  void offeradded(Event event){
    bestOffer=new Offer.snapshot(event.snapshot);
    setState(()=>bestOffer.price);
    setState(()=>bestOffer.email);
  }

  void auctionUpdated(Event event){
    auction.id=event.snapshot.key!;
     auction= new Auction.snapshot(event.snapshot) ;
    setState(()=>auction.timer);
  }
 void startauction()async{
   if (timercontroller.text.isEmpty) setState(()=>error='please enter auction timer');
   else{
     if(int.parse(timercontroller.text)<1)setState(()=> error='timer cannot be less than 1 minuet');
     else{
       auction.timer=int.parse(timercontroller.text);
      await admindb.startauction(auction);
      await db.addoffer(auction.auctionStatrtPrice, 'manoshko');
      Navigator.of(context).pushReplacementNamed('/viewAuction');
      admindb.starttimer(auction);

     }

   }
 }




  void bottombar(int x) {
    if (x == 0) {
      Navigator.of(context).pushReplacementNamed('/adminhome');
    }
    else {
      Navigator.of(context).pushReplacementNamed('/adminprofile');
    }
  }
  gridView(String photo) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
          crossAxisCount:  1,
          // childAspectRatio: 1.0,
          //     mainAxisSpacing: 4.0,
          //crossAxisSpacing: 4.0,
          children:[Utility.imageFromBase64String(photo)]
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auction=widget.auction;
    onauctionUpdated=dbReference.onChildChanged.listen(auctionUpdated);
    onofferadded=offersrefrence.onChildAdded.listen(offeradded);


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    onauctionUpdated.cancel();
    onofferadded.cancel();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange.shade400,
        centerTitle: true,
        title: new Text('Auction of ${auction.product.name}', style: TextStyle(
            color: Colors.white,
            fontSize: 25
        ),
        ),
      ),
      body:(auction.auctionState=='inprogress')? new Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: new ListView(
          children: [

            new Padding(padding: EdgeInsets.only(bottom: 5)),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Text('${auction.timer}',style: TextStyle(fontSize: 60,color: Colors.red,fontWeight: FontWeight.w700),),
                new Padding(padding: EdgeInsets.only(bottom: 10)),
                new Text('Best Offer:  ${bestOffer.price} EGP',style: TextStyle(fontSize: 20,color:Colors.green ,fontWeight: FontWeight.w700),),
                new Padding(padding: EdgeInsets.only(bottom: 10)),
                new Text('From:  ${bestOffer.email}',style: TextStyle(fontSize: 18,color:Colors.orangeAccent,fontWeight: FontWeight.w700),),
                new Padding(padding: EdgeInsets.only(bottom: 10)),
                new SizedBox(
                  height:120,
                  width: 70,
                  child: Utility.imageFromBase64String(auction.product.image),
                ),
              ],
            ),
            new TextField(
              enabled: false,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black54,
              decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                  icon: new Icon(
                    Icons.edit,
                    color: Colors.deepOrange.shade400,
                  ),
                  labelText: 'Product Name:   ${widget.auction.product.name}',
                  labelStyle:
                  TextStyle(color: Colors.blueGrey.shade800, fontSize: 16)),
            ),

          ],
        ),
      ): (auction.auctionState=='finished')? new Container(
        padding: EdgeInsets.only(left: 30,right: 30),
        child: new ListView(
          children: [
            new Padding(padding: EdgeInsets.only(bottom: 10)),
            new Text('Winner: ${auction.winner}',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w700),),
            new Padding(padding: EdgeInsets.only(bottom: 10)),
            new Text('sold price:  ${auction.soldPrice} EGP',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w700),),
            new Padding(padding: EdgeInsets.only(bottom: 20)),
            new SizedBox(
              height:150,
              child: Utility.imageFromBase64String(widget.auction.product.image),
            ),
            new Padding(padding: EdgeInsets.only(bottom: 5)),
            new TextField(
              enabled: false,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black54,
              decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                  icon: new Icon(
                    Icons.edit,
                    color: Colors.deepOrange.shade400,
                  ),
                  labelText: 'Product Name: ${widget.auction.product.name}',
                  labelStyle:
                  TextStyle(color: Colors.blueGrey.shade800, fontSize: 16)),
            ),

          ],
        ),
      ): new Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: new ListView(
          children: [
            new SizedBox(
              height:200,
              child: Utility.imageFromBase64String(widget.auction.product.image),
            ),
            new Padding(padding: EdgeInsets.only(bottom: 5)),
            new TextField(
              enabled: false,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black54,
              decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                  icon: new Icon(
                    Icons.insert_drive_file,
                    color: Colors.green,
                  ),
                  labelText: 'name:   ${widget.auction.product.name}',
                  labelStyle:
                  TextStyle(color: Colors.blueGrey.shade800, fontSize: 16)),
            ),
            new TextField(
              enabled: false,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black54,
              decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                  icon: new Icon(
                    Icons.ac_unit,
                    color: Colors.green,
                  ),
                  labelText: 'State:   ${widget.auction.auctionState}',
                  labelStyle:
                  TextStyle(color: Colors.blueGrey.shade800, fontSize: 16)),
            ),
            new TextField(
              enabled: false,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black54,
              decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                  icon: new Icon(
                    Icons.monetization_on,
                    color: Colors.green,
                  ),
                  labelText: 'startPrice:   ${widget.auction.auctionStatrtPrice}',
                  labelStyle:
                  TextStyle(color: Colors.blueGrey.shade800, fontSize: 16)),
            ),
            new TextField(
              autocorrect: true,
              keyboardAppearance: Brightness.dark,
              controller: timercontroller,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black54,
              decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                  icon: new Icon(
                    Icons.timer,
                    color: Colors.deepOrange,
                  ),
                  labelText: 'timer by minutes',
                  labelStyle:
                  TextStyle(color: Colors.orange, fontSize: 16)),
            ),
            new Padding(padding: EdgeInsets.only(bottom: 10)),
            new Text('$error',
              style: TextStyle(
                color: Colors.red.shade800,
                fontSize: 14,
              ),
            ),
            new RaisedButton(
              onPressed: startauction ,
              child: new Text('startAuction',style: TextStyle(color: Colors.white),),
              color: Colors.deepOrange.shade400,

            )





          ],
        ),
      ) ,
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home,color: Colors.orangeAccent), title: new Text('HOME',style:TextStyle( fontSize: 16,color: Colors.blueGrey))),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.account_box,color: Colors.orangeAccent,), title: new Text('PROFILE',style:TextStyle(fontSize: 16,color: Colors.blueGrey))),
        ],
        onTap: bottombar,
        type: BottomNavigationBarType.fixed,
      ),

    );

  }

}