import 'package:auction/controller/Utility.dart';
import 'package:auction/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class productdetails extends StatefulWidget {
  final Product product;
  productdetails(this.product);
  @override
  State<StatefulWidget> createState() {
    return new productdetailsstate();
  }
}
class productdetailsstate extends State<productdetails>{
 late Product product;
  void bottombar(int x) {
    if (x == 0) {
      Navigator.of(context).pushReplacementNamed('/userhome');
    }
    else {
      Navigator.of(context).pushReplacementNamed('/userprofile');
    }
  }
  gridview(String photo){

    return Padding(

      padding: EdgeInsets.all(0),
      child: GridView.count(
        childAspectRatio: 1.2,

        crossAxisCount: 1,
        children: [Utility.imageFromBase64String(photo),

        ],
      ),

    );


  }

  @override
  void initState() {
    super.initState();
     product=widget.product;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(

        backgroundColor:Colors.red,
        title: new Text(
          'Details of ${product.name}',
          textDirection: TextDirection.ltr,
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
      body:new Container(
          child:new ListView(
            padding: EdgeInsets.all(10),
            children: [
              new SizedBox(
                child:  gridview(product.image),
                height: 350,
              ),



              //images of product
              new Text('EGP ${product.price}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800)),
              new Padding(padding: EdgeInsets.only(bottom: 5)),
              new Text('Description',style: TextStyle(backgroundColor: Colors.teal,color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),),
              new Padding(padding: EdgeInsets.only(bottom: 5)),
              new Text('${product.description}',style: TextStyle(color: Colors.blueGrey.shade800,fontSize: 18,fontWeight: FontWeight.w700),),
            ],



          )
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