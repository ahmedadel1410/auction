import 'dart:async';
import 'package:auction/controller/Utility.dart';
import 'package:auction/model/auction.dart';
import 'package:auction/view/user/startbiding.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auctionfinished.dart';

class viewauctions extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return viewauctionsState();
  }

}
class viewauctionsState extends State<viewauctions> {
  final dbReference = FirebaseDatabase.instance.reference().child('auction');
  List<Auction>auctions=[];
  late StreamSubscription<Event> _onAuctionadded;
  late StreamSubscription<Event> _onAuctionchanged;
  Widget listTile =new ListTile();

  void bottombar(int x) {
    if (x == 0) {
      Navigator.of(context).pushReplacementNamed('/userhome');
    }
    if(x==1) {
      Navigator.of(context).pushReplacementNamed('/userprofile');
    }
  }

  void auctionadded(Event event){
    setState(() {
      auctions.add(new Auction.snapshot(event.snapshot));
    });
  }

  void auctionchanged(Event event){
    Auction oldAuctionvalue=auctions.singleWhere((element){
      return element.id==event.snapshot.key;
    });
      auctions[auctions.indexOf(oldAuctionvalue)]= new Auction.snapshot(event.snapshot);

  }

  gridView() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        childAspectRatio: 0.8,
        crossAxisCount:  2,
        children:auctions.map((auction){
            return  listTile = new ListTile(
                onTap:(auction.auctionState=='inprogress') ? ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>new startbiding(auction) ))
                    : (auction.auctionState=='finished') ?  ()=>Navigator.push(context, MaterialPageRoute(builder:(context)=>new auctionfinished(auction) ))
                : null,

                contentPadding: EdgeInsets.all(0),
                title: new Card(
                  color: (auction.auctionState=='inprogress')? Colors.green :(auction.auctionState=='finished') ? Colors.red.shade700
                      : Colors.white70,
                    elevation: 5,
                    margin: EdgeInsets.all(2),
                    child: new Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        new Padding(padding: EdgeInsets.only(top: 5)),
                        new SizedBox(
                          height:130,
                          width: 100,
                          child: Utility.imageFromBase64String(auction.product.image),
                        ),
                        new Padding(padding: EdgeInsets.only(top: 10)),
                        new Text('${auction.product.name}',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400)),
                        new Padding(padding: EdgeInsets.only(top: 5)),
                        new Text('EGP ${auction.product.price}',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400)),
                        new Padding(padding: EdgeInsets.only(top: 5)),
                        new Text('${auction.auctionState}',style: TextStyle(color: Colors.amber,fontSize: 17,fontWeight: FontWeight.w700)),
                      ],
                    )
                )
            );

        }
        ).toList(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _onAuctionadded=dbReference.onChildAdded.listen(auctionadded);
      _onAuctionchanged=dbReference.onChildChanged.listen(auctionchanged);

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onAuctionadded.cancel();
    _onAuctionchanged.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.red,
        title:new Column(
          children: [
            new Padding(padding: EdgeInsets.only(top:23 )),
            new Text('Auctions',style: TextStyle(color: Colors.orangeAccent.shade400,fontSize: 30,backgroundColor: Colors.white,),) ,
          ],
        ),
        centerTitle: true,
      ),

      body: new Column(
        children: <Widget>
        [
          Flexible(child: gridView())
        ],
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