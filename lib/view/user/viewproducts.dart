import 'dart:async';

import 'package:auction/controller/Utility.dart';
import 'package:auction/controller/dbcontroller.dart';
import 'package:auction/model/product.dart';
import 'package:auction/view/user/productdetails.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class viewproducts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return viewproductsstate();
  }

}
class viewproductsstate extends State<viewproducts> {
  final dbReference = FirebaseDatabase.instance.reference().child('product');
  List<Product>products=[];
  late StreamSubscription<Event> _onProductAdded;
  late StreamSubscription<Event> _onProductChanged;

  void bottombar(int x) {
    if (x == 0) {
      Navigator.of(context).pushReplacementNamed('/userhome');
    }
    if(x==1) {
      Navigator.of(context).pushReplacementNamed('/userprofile');
    }
  }

  void productAdded(Event event){
    setState(() {
      products.add(new Product.fromSnapShot(event.snapshot));
    });
  }

  void productChanged(Event event){
    Product oldstudentvalue=products.singleWhere((element)=>element.id==event.snapshot.key);
    setState(() {
      products[products.indexOf(oldstudentvalue)]=new Product.fromSnapShot(event.snapshot);

    });
  }

  gridView() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        childAspectRatio: 0.8,
        crossAxisCount:  2,
        children:products.map((product){
          return  new ListTile(
            contentPadding: EdgeInsets.all(0),
            title: new Card(
                elevation: 5,
                margin: EdgeInsets.all(2),
                child:new Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    new Padding(padding: EdgeInsets.only(top: 5)),
                    new SizedBox(
                      height:130,
                      width: 100,
                      child: Utility.imageFromBase64String(product.image),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 10)),
                    new Text('${product.name}',style: TextStyle(color: Colors.blueGrey.shade600,fontSize: 15,fontWeight: FontWeight.w400)),
                    new Padding(padding: EdgeInsets.only(top: 5)),
                    new Text('${product.type}',style: TextStyle(color: Colors.blueGrey.shade600,fontSize: 15,fontWeight: FontWeight.w400)),
                    new Padding(padding: EdgeInsets.only(top: 5)),
                    new Text('EGP ${product.price}',style: TextStyle(color: Colors.blueGrey.shade600,fontSize: 15,fontWeight: FontWeight.w600)),
                  ],
                )
            ),
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(context)=>new productdetails(product) ))
          ,
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
      _onProductAdded=dbReference.onChildAdded.listen(productAdded);
      _onProductChanged=dbReference.onChildChanged.listen(productChanged);

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onProductAdded.cancel();
    _onProductChanged.cancel();
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
            new Text('Products',style: TextStyle(color: Colors.orangeAccent.shade400,fontSize: 30,backgroundColor: Colors.white,),) ,
          ],
        ),
        centerTitle: true,
      ),

      body: new Column(
        children: <Widget>
        [
          Flexible(child:  gridView())
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