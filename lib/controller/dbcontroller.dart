import 'dart:async';

import 'package:auction/model/offer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dbController extends ChangeNotifier{
  String loginState='';
  String? googleEmail;
  String signuperror='';
 final userRefrence=FirebaseDatabase.instance.reference().child('users');
  final offersRefrence=FirebaseDatabase.instance.reference().child('offers');

  login(String email,String password)async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password:password).then((value)async{
      loginState='successful';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
    }).catchError((e){
      loginState='invalid user name or password';
    });
    notifyListeners();

  }
  Future googlelogin()async{
    GoogleSignIn googlesignin = new GoogleSignIn();
    await googlesignin.signIn().then((googleuser)async{
      await googleuser!.authentication.then((googleauth)async{
        final credential=GoogleAuthProvider.credential(
            idToken: googleauth.idToken,
            accessToken: googleauth.accessToken
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        loginState='successful';
         googleEmail=googleuser.email;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', googleuser.email);
        notifyListeners();


      });

    }).catchError((e){
      loginState='cannot login with google';
    });
  }
 Future<bool> signup(String email, String firstname,String lastname,String password, String gender)async{
    bool signup = false;
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
      await  userRefrence.push().set({
          'firstname': firstname,
          'lastname':lastname,
          'email':email,
          'password': password,
          'gender':gender,
        });
      signup=true;
    }).catchError((e){
      signup= false;
    });
    return signup;
  }

  Future logout()async{
    GoogleSignIn googlesignin = new GoogleSignIn();
    if(await googlesignin.isSignedIn())await  googlesignin.disconnect();
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs =await SharedPreferences.getInstance();
    await prefs.remove('email');
    notifyListeners();
  }
  addoffer(int price,String email){
    offersRefrence.push().set({
      'email': email,
      'price': price
    });

  }
}