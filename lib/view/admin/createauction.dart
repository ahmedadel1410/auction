import 'package:auction/controller/Utility.dart';
import 'package:auction/controller/admincontroller.dart';
import 'package:auction/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class createAuction extends StatefulWidget{
  final Product product;
  createAuction(this.product);
  @override
  State<StatefulWidget> createState() {
   return createAuctionState();
  }
  
  
}
class createAuctionState extends State <createAuction>{
  String error='';
  TextEditingController startPrice= new TextEditingController();
  TextEditingController timerValue= new TextEditingController();
  adminController admindb = new adminController();
  void create()async{
      if(startPrice.text.isEmpty) setState(()=> error='please enter starting price' );
      else {
       await admindb.addAuction(widget.product, int.parse(startPrice.text));
       setState(() =>error='successfully added');
       Navigator.of(context).pushReplacementNamed('/viewallproducts');
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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange.shade400,
        centerTitle: true,
        title: new Text('New Auction', style: TextStyle(
            color: Colors.white,
            fontSize: 25
        ),
        ),
      ),
      body: new Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        child:new ListView(
          children: [
            new SizedBox(
              child:Utility.imageFromBase64String(widget.product.image) ,
              height:200,
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
                  labelText: 'name:   ${widget.product.name}',
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
                  labelText: 'price:   ${widget.product.price}',
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
                    Icons.format_indent_decrease,
                    color: Colors.green,
                  ),
                  labelText: 'type:   ${widget.product.type}',
                  labelStyle:
                  TextStyle(color: Colors.blueGrey.shade800, fontSize: 16)),
            ),
      new TextField(
        autocorrect: true,
        keyboardAppearance: Brightness.dark,
        controller: startPrice,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.black54,
        decoration: new InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade800)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade800)),
            icon: new Icon(
              Icons.monetization_on_outlined,
              color: Colors.deepOrange,
            ),
            labelText: 'Start Price',
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
                onPressed: create ,
              child: new Text('Create',style: TextStyle(color: Colors.white),),
              color: Colors.deepOrange.shade400,

            )




          ],
        )
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home, color: Colors.orangeAccent),
              title: new Text('HOME',
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey))),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.account_box, color: Colors.orangeAccent,),
              title: new Text('PROFILE',
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey))),
        ],
        onTap: bottombar,
        type: BottomNavigationBarType.fixed,
      ),


    );
    
  }
  
}