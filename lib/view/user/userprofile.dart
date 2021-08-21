import 'package:auction/controller/dbcontroller.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class userprofile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new userprofileState();
  }
}
class userprofileState extends State<userprofile>{
  dbController db = new dbController();
  var user=FirebaseAuth.instance.currentUser!;

  void bottombar(int x) {
    if (x == 0) {
      Navigator.of(context).pushReplacementNamed('/userhome');
    }
    else {
      Navigator.of(context).pushReplacementNamed('/userprofile');
    }
  }
  void logout()async{
    await db.logout();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context)=>ChangeNotifierProvider(create: (context)=>dbController(),
    child:
    new Scaffold(
      backgroundColor: Colors.white,

      appBar: new AppBar(

        backgroundColor:Colors.red,
        actions: [

          new IconButton(
              onPressed: logout,
              icon: new Icon(Icons.logout, color: Colors.white)),
        ],
        title: new Text(
          'Profile',
          textDirection: TextDirection.ltr,
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
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
            SizedBox(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:(user.photoURL==null) ? NetworkImage('') : NetworkImage(user.photoURL!),
              ),
              height:150 ,
              width: 150,
            ),
            new Padding(padding: EdgeInsets.only(bottom: 20)),

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
                    Icons.email,
                    color: Colors.deepOrange.shade400,
                  ),
                  labelText: '${user.email}',
                  labelStyle:
                  TextStyle(color: Colors.blueGrey.shade800, fontSize: 15)),
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
                    Icons.perm_contact_cal,
                    color: Colors.deepOrange.shade400,
                  ),
                  labelText:(user.displayName==null)? '' :'${user.displayName}',
                  labelStyle:
                  TextStyle(color: Colors.blueGrey.shade800, fontSize: 16)),
            ),          ],
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
    ),
  ) ;



}