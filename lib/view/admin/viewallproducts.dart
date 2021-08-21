import 'dart:async';
import 'package:auction/controller/Utility.dart';
import 'package:auction/controller/admincontroller.dart';
import 'package:auction/model/product.dart';
import 'package:auction/view/admin/addproduct.dart';
import 'package:auction/view/admin/createauction.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class viewallproducts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return viewallproductsstate();
  }

}
class viewallproductsstate extends State <viewallproducts>{
  final dbReference = FirebaseDatabase.instance.reference().child('product');
  List<Product>products=[];
  adminController admindb = new adminController();
  late StreamSubscription<Event> _onProductAdded;
  late StreamSubscription<Event> _onProductChanged;
  void bottombar(int x) {
    if (x == 0) {
      Navigator.of(context).pushReplacementNamed('/adminhome');
    }
    else {
      Navigator.of(context).pushReplacementNamed('/adminprofile');
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
  void delete(BuildContext context,Product product,int position)async{
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Deleting ${product.name}'),
            content: new Text('are you sure ?'),
            actions: [
              new FlatButton(
                  onPressed: ()async{
                    await admindb.deleteproduct(product.id);
                    setState(() {
                      products.removeAt(position);

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
        title:new Text('Our products',style: TextStyle(color: Colors.white,fontSize: 22),) ,
        centerTitle: true,

      ),
      body:new ListView.builder(
        itemCount: products.length,
        // itemCount:_products.data.length,

        itemBuilder:(context,int position){
          return new Card(
            color: Colors.blueGrey,
            child: new Row(
              children: [

                Expanded(child: new ListTile(
                  title: new Text('${products[position].name}',style: TextStyle(color: Colors.tealAccent,fontSize: 16)),

                  subtitle: new Text('Type: ${products[position].type}'+'\n'+'price: ${products[position].price}',style: TextStyle(color: Colors.white,fontSize: 16)),

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
                  onTap:()=> Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> createAuction(products[position]))),
                ) ,
                ),
                new IconButton(
                    onPressed:()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>new addproduct(products[position]))),
                    icon: new Icon(Icons.edit,color: Colors.tealAccent,size: 28,)),
                new IconButton(onPressed:()=>delete(context,products[position],position), icon: new Icon(Icons.delete_forever,color: Colors.tealAccent,size: 28,)),

                new SizedBox(
                  width:80,
                  height:85,
                  child: gridView(products[position].image),


                ),

              ],
            ),


          );
        } ,
      ) ,
        floatingActionButton: new FloatingActionButton(onPressed:(){Navigator.of(context).pushReplacementNamed('/addproduct');},
          child: new Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.orangeAccent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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