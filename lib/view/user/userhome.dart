import 'package:auction/controller/dbcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class userHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return userHomeState();
  }

}
class userHomeState extends State<userHome> {
  dbController db = new dbController();
  void bottombar(int x) {
    if (x == 0) {
      Navigator.of(context).pushReplacementNamed('/userhome');
    }
    if(x==1) {
      Navigator.of(context).pushNamed('/userprofile');
    }
  }

  void logout()async{
    await db.logout();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }
  @override
  Widget build(BuildContext context) {
  return  new Scaffold(
      backgroundColor: Colors.white,

      appBar: new AppBar(

        backgroundColor:Colors.red,
        actions: [

          new IconButton(
              onPressed: logout,
              icon: new Icon(Icons.logout, color: Colors.white)),
        ],
        title: new Text(
          'MaNoOshKo',
          textDirection: TextDirection.ltr,
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),

      body:new Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(left: 20,right: 20),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new TextButton.icon(
                onPressed:()=> Navigator.of(context).pushNamed('/viewproducts'),
                icon: new Icon(Icons.shopping_cart,size: 40,color: Colors.orange,),
                label: new Text('Products',style: TextStyle(fontSize: 26,color: Colors.blueGrey.shade800),)),
            new Padding(padding: EdgeInsets.only(bottom: 50)),
            new TextButton.icon(
                onPressed:()=> Navigator.of(context).pushNamed('/viewauctions'),

                icon: new Icon(Icons.account_balance,size: 40,color: Colors.brown.shade900),
                label: new Text('Auctions',style: TextStyle(fontSize: 26,color: Colors.black),))


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