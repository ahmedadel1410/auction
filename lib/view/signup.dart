import 'package:auction/controller/dbcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class signup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new signupState();
  }

}

class signupState extends State<signup> {
  dbController db =new dbController();
  String error = '';
  int gendervalue=0;
  String gender='';
  TextEditingController _firstname = new TextEditingController();
  TextEditingController _lastname = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _confirmpassword = new TextEditingController();

  void signup()async{
      if (_email.text.isEmpty || _firstname.text.isEmpty ||
          _lastname.text.isEmpty || _password.text.isEmpty ||
          _confirmpassword.text.isEmpty)
        error = 'please fill requirements';
      else if (_firstname.text.length < 3 || _lastname.text.length < 3)
        error = 'Name must be at least 3 characters!';
      else if (_password.text.length < 6)
        error = 'Password must be at least 6 characters!';
      else if (_confirmpassword.text.trim() != _password.text.trim())
        error = "your password doesn't match !!";
      else if (validateemail(_email.text) == 0) {}
      else {
        if (gendervalue == 0)
          gender = 'male';
        else
          gender = 'female';

       if(await db.signup(_email.text, _firstname.text, _lastname.text, _password.text, gender)==true) await Navigator.of(context).pushReplacementNamed('/userhome');
       else error='cannot signup maybe this mail taken';
      }
      setState(()=> error);



  }
  int validateemail(String email){
    if( email.startsWith(new RegExp('[a-z]'),0)){
      if(email.contains("@")){
        if(email.endsWith("@")){
          error="mail can't end with (@)!!";
          return 0;

        }
        else{
          var  username =email.split("@");

          if(RegExp(r'[!@#<>?":`~;[\]\\|=+)(*&^%\s-]').hasMatch(username[0])){
            error="email shouldn't contain special characters !!";
            return 0;

          }
          else if (username[0].endsWith('.')|| username[0].endsWith('_')||username[1].endsWith('@')){
            error='email must end with letter or number';
            return 0;

          }
          else if (!RegExp(r'^(?!.*[._]{2})[a-zA-Z0-9_.]+$').hasMatch(username[0])){
            error="email can't contain consecutive (.)or(_) ";
            return 0;

          }

          else if(username[1]=='gmail.com'|| username[1]=='yahoo.com'||username[1]=='outlook.com'){
            var usernamevalid=username[0]+username[1];
            if(usernamevalid.length<16){
              error="mail must be  at least 16 characters!";
              return 0;

            }
            else{
              return 1;
            }


          }
          else{
            error='mail unrecognized it should be\n    (gmail-yahoo-outlook)';
            return 0;
          }

        }


      }
      else {
        error='not a valid mail';
        return 0;
      }
    }
    else{
      error='email must start with a letter !';
      return 0;
    }


  }

  void genderType(int? value) {
    setState(() {
      gendervalue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: new AppBar(
          backgroundColor: Colors.red,
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
        body: new Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.topLeft,
            child: new ListView(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                new TextField(
                  controller: _firstname,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black54,
                  decoration: new InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      icon: new Icon(Icons.person,
                        color: Colors.orangeAccent,),
                      labelText: 'First Name',
                      labelStyle: TextStyle(
                          color: Colors.orangeAccent, fontSize: 20)),
                ),
                new Padding(padding: EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 10.0),),
                new TextField(
                  controller: _lastname,
                  keyboardType: TextInputType.name,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black54,
                  decoration: new InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      icon: new Icon(Icons.person,
                        color: Colors.orangeAccent,),
                      labelText: 'Last Name',
                      labelStyle: TextStyle(
                          color: Colors.orangeAccent, fontSize: 20)),
                ),
                new Padding(padding: EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 10.0),),
                new TextField(
                  /*inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))
              ],*/

                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black54,
                  decoration: new InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      icon: new Icon(Icons.email,
                        color: Colors.orangeAccent,),
                      labelText: 'E-mail',
                      labelStyle: TextStyle(
                          color: Colors.orangeAccent, fontSize: 20)),
                ),

                new Padding(padding: EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 10.0),),
                new TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  controller: _password,

                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black54,
                  autocorrect: true,
                  autofocus: true,
                  decoration: new InputDecoration(

                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange,)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      icon: new Icon(Icons.password,
                        color: Colors.orangeAccent,),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Colors.orangeAccent, fontSize: 20)),
                ),
                new Padding(padding: EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 10.0),),
                new TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  controller: _confirmpassword,

                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black54,
                  autocorrect: true,
                  autofocus: true,
                  decoration: new InputDecoration(

                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange,)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      icon: new Icon(Icons.password,
                        color: Colors.orangeAccent,),
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                          color: Colors.orangeAccent, fontSize: 20)),
                ),
                new Padding(padding: EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 10.0),),
                new Row(
                  children: [
                    new Icon(Icons.transgender, color: Colors.orangeAccent,),
                    new Padding(padding: EdgeInsets.only(
                        left: 0, right: 15, top: 0, bottom: 0.0),),
                    new Text('Gender :', style: TextStyle(
                      color: Colors.orangeAccent, fontSize: 22,),),
                    new Padding(padding: EdgeInsets.only(
                        left: 0, right: 5, top: 0, bottom: 0.0),),
                    Expanded(child: new Row(children: [
                      new Text('Male',
                          style: TextStyle(color: Colors.brown.shade900,)),
                      new Radio(value: 0,
                        groupValue: gendervalue,
                        onChanged: genderType,
                        activeColor: Colors.brown,),
                      new Text('Female',
                          style: TextStyle(color: Colors.pinkAccent,)),
                      new Radio(value: 1,
                        groupValue: gendervalue,
                        onChanged: genderType,
                        activeColor: Colors.pinkAccent,)
                    ],))


                  ],
                ),
                new Padding(padding: EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 10.0),),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Text("$error",
                        style: TextStyle(
                          color: Colors.red.shade800,
                          fontSize: 14,
                        )
                    )
                  ],
                ),
                new Padding(padding: EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 50.0),),
                new RaisedButton(
                  padding: new EdgeInsets.all(12),
                  color: Colors.red,
                  onPressed: signup,
                  child: new Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      //fontStyle: FontStyle.italic,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ),

              ],
            )


        )

    );
  }
}


