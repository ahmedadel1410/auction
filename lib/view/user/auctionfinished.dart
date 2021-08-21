import 'package:auction/controller/Utility.dart';
import 'package:auction/model/auction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class auctionfinished extends StatefulWidget{
  final Auction auction;
  auctionfinished(this.auction);
  @override
  State<StatefulWidget> createState() {

    return auctionfinishedState();
  }

}
class auctionfinishedState extends State <auctionfinished>{
  late Auction auction ;

  void bottombar(int x) {
    if (x == 0) {
      Navigator.of(context).pushReplacementNamed('/userhome');
    }
    else {
      Navigator.of(context).pushReplacementNamed('/userprofile');
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
      body:  new Container(
        padding: EdgeInsets.only(left: 30,right: 30),
        child: new ListView(
          children: [
            new Padding(padding: EdgeInsets.only(bottom: 10)),
            new Text('Winner : ${auction.winner}',style: TextStyle(fontSize: 20,color: Colors.orangeAccent,fontWeight: FontWeight.w700),),
            new Padding(padding: EdgeInsets.only(bottom: 10)),
            new Text('Best Offer : ${auction.soldPrice} EGP',style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.w700),),

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

      ),
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