import 'dart:async';
import 'package:auction/controller/Utility.dart';
import 'package:auction/controller/admincontroller.dart';
import 'package:auction/model/auction.dart';
import 'package:auction/view/admin/AuctionFinished.dart';
import 'package:auction/view/admin/startAuction.dart';
import 'package:auction/view/user/auctionfinished.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class viewAuction extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return viewAuctionState();
  }

}
class viewAuctionState extends State <viewAuction>{
  final dbReference = FirebaseDatabase.instance.reference().child('auction');
  List<Auction>auctions=[];
  adminController admindb = new adminController();
  late StreamSubscription<Event> onAuctionAdded;
  late StreamSubscription<Event> onAuctionUpdated;
  void bottombar(int x) {
    if (x == 0) {
      Navigator.of(context).pushReplacementNamed('/adminhome');
    }
    else {
      Navigator.of(context).pushReplacementNamed('/adminprofile');
    }
  }
  void auctionAdded(Event event){
    setState(() {
      auctions.add(new Auction.snapshot(event.snapshot));
    });

  }
  void auctionUpdated(Event event){
    Auction oldAuctionvalue=auctions.singleWhere((element){
      return element.id==event.snapshot.key;
    });
      auctions[auctions.indexOf(oldAuctionvalue)]= new Auction.snapshot(event.snapshot);
  }
  void delete(BuildContext context,Auction auction,int position)async{
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Deleting Auction of ${auction.product.name}'),
            content: new Text('are you sure ?'),
            actions: [
              new FlatButton(
                  onPressed: ()async{
                    await admindb.deleteauction(auction.id);
                    setState(() {
                      auctions.removeAt(position);

                    });
                    Navigator.pop(context);},
                  child: new Text('Yes')),
              new FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: new Text("No")),
            ],
          );
        });



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
    setState(() {
      onAuctionAdded=dbReference.onChildAdded.listen(auctionAdded);
      onAuctionUpdated=dbReference.onChildChanged.listen(auctionUpdated);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    onAuctionAdded.cancel();
    onAuctionUpdated.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title:new Text('Our Auctions',style: TextStyle(color: Colors.white,fontSize: 22),) ,
        centerTitle: true,

      ),
      body:new ListView.builder(
        itemCount: auctions.length,
        // itemCount:_products.data.length,

        itemBuilder:(context,int position){
          return new Card(
            color: Colors.blueGrey,
            child: new Row(
              children: [

                Expanded(child: new ListTile(
                  title: new Text('${auctions[position].product.name}',style: TextStyle(color: Colors.tealAccent,fontSize: 20)),

                  subtitle: new Text(
                      'state: ${auctions[position].auctionState}'+
                      '\n'+'start price : ${auctions[position].auctionStatrtPrice}\n'+
                          'timer : ${auctions[position].timer}\n'+
                          'soldPrice : ${auctions[position].soldPrice}',

                      style: TextStyle(color: Colors.white,fontSize: 16)),

                  // title: new Text(' ${getproductidname(position)}',style: TextStyle(color: Colors.orangeAccent,fontSize: 18)),
                  //subtitle:new Text('${getproducttypeprice(position)}',style: TextStyle(color: Colors.white,fontSize: 16))
                  leading: new Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 18.0,
                        child: new Text('${position+1}',style: TextStyle(color: Colors.white,fontSize: 20)),

                      )
                    ],
                  ),
                  onTap: (auctions[position].auctionState=='finished') ?  ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>new AuctionFinished(auctions[position]) ))
         : ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>new startAuction(auctions[position])))
                ) ,
                ),

                new IconButton(onPressed:()=>delete(context,auctions[position],position), icon: new Icon(Icons.delete_forever,color: Colors.tealAccent,size: 28,)),
                new SizedBox(
                  width:80,
                  height:85,
                  child: gridView(auctions[position].product.image),


                ),

              ],
            ),


          );
        } ,
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