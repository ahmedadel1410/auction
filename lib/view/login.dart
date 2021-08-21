import 'package:auction/controller/dbcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new loginState();
  }
}

class loginState extends State<login> {

  dbController db = new dbController();
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  String error='' ;

  void login()async{
    if(_username.text.isEmpty|| _password.text.isEmpty) error='please enter username and password!';
    await db.login(_username.text,_password.text);
    if(db.loginState=='successful'){
      if(_username.text=='ahmedlord1410@gmail.com'&& _password.text=='ahmed1410') Navigator.of(context).pushReplacementNamed('/adminhome');
      else  Navigator.of(context).pushReplacementNamed('/userhome');
    }
    else setState(() {
      error=db.loginState;
    });
  }
  void googlelogin()async{
   await  db.googlelogin();
   if(db.loginState=='successful')
     {
       if(db.googleEmail=='ahmedlord1410@gmail.com') Navigator.of(context).pushReplacementNamed('/adminhome');
       else Navigator.of(context).pushReplacementNamed('/userhome');
     }
   else {
     setState(() {
       error = db.loginState;
     });
   }

  }
  @override
  Widget build(BuildContext context)=> ChangeNotifierProvider(
    create: (context)=> dbController(),
    child:new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
          child: new ListView(
            //  mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new Container(
                  padding:
                  EdgeInsets.only(left: 0, right: 0, top: 60.0, bottom: 0.0),
                  color: Colors.red,
                  child: new Column(
                    children: [
                      new Image.asset(
                        'images/69-692296_m-logo-polygon.png',
                        height: 130,
                        width: 110,
                        color: Colors.orangeAccent,
                      ),
                      new Text(
                        'MaNoOshKo',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            backgroundColor: Colors.white,
                            color: Colors.orangeAccent,
                            fontSize: 30,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              new Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 50.0),
              ),
              new Row(
                children: [
                  new Padding(
                    padding:
                    EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0.0),
                  ),
                  Expanded(
                    child: new TextField(
                      autocorrect: true,
                      keyboardAppearance: Brightness.dark,
                      controller: _username,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black54,
                      decoration: new InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange)),
                          icon: new Icon(
                            Icons.email,
                            color: Colors.orangeAccent,
                          ),
                          labelText: 'User name',
                          labelStyle:
                          TextStyle(color: Colors.orangeAccent, fontSize: 18)),
                    ),
                  )
                ],
              ),
              new Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 15.0),
              ),
              new Row(
                children: [
                  new Padding(
                    padding:
                    EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0.0),
                  ),
                  Expanded(
                    child: new TextField(
                      obscureText: true,
                      controller: _password,
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black54,
                      autocorrect: true,
                      decoration: new InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.orange,
                              )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange)),
                          icon: new Icon(
                            Icons.password,
                            color: Colors.orangeAccent,
                          ),
                          labelText: 'Password',
                          labelStyle:
                          TextStyle(color: Colors.orangeAccent, fontSize: 18)),
                    ),
                  )
                ],
              ),
              new Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 10.0),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Text("$error",
                      style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 14,
                      ))
                ],
              ),
              new Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30.0),
              ),
              new Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child:  Row(
                    children: [
                      Expanded(
                          child:new ElevatedButton.icon(onPressed:login,
                            icon: new FaIcon(FontAwesomeIcons.child , color: Colors.white,),
                            label: new Row(children: [new Text('LOGIN',style: TextStyle(color: Colors.white,fontSize: 20)),
                            ]),
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red),

                            ),
                          )
                      )
                    ]
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 10.0),
              ),
              new Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child:  Row(
                    children: [
                      Expanded(
                          child:new ElevatedButton.icon(onPressed:googlelogin ,
                            icon: new FaIcon(FontAwesomeIcons.google , color: Colors.lightBlue.shade600,),
                            label: new Row(children: [new Text('oog',style: TextStyle(color: Colors.orange,fontSize: 28)),
                              new Text('le',style: TextStyle(color: Colors.red,fontSize: 28))]),
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white60),

                            ),
                          )
                      )
                    ]
                ),
              ),

              new Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 10.0),
              ),

              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Text("Don't have an account? "),
                  new FlatButton(
                      onPressed:(){Navigator.of(context).pushNamed('/signup');},
                      child: new Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ))
                ],
              )
            ],
          )),
    ) ,
  );


}
