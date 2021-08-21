import 'package:auction/view/admin/addproduct.dart';
import 'package:auction/view/admin/adminhome.dart';
import 'package:auction/view/admin/adminprofile.dart';
import 'package:auction/view/admin/createauction.dart';
import 'package:auction/view/admin/startAuction.dart';
import 'package:auction/view/admin/viewAuction.dart';
import 'package:auction/view/admin/viewallproducts.dart';
import 'package:auction/view/login.dart';
import 'package:auction/view/signup.dart';
import 'package:auction/view/user/userhome.dart';
import 'package:auction/view/user/userprofile.dart';
import 'package:auction/view/user/viewauctions.dart';
import 'package:auction/view/user/viewproducts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/dbcontroller.dart';
import 'model/auction.dart';
import 'model/product.dart';
String? email;
Product product=new Product(name: '', type: '', price: 0, image: '',description: '');
Auction? auction;
void main()async{
   WidgetsFlutterBinding.ensureInitialized();
   SharedPreferences pref = await SharedPreferences.getInstance();
   email = pref.getString('email');
  await Firebase.initializeApp();
  print(email);

  runApp(Myapp());
}
class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context)=>ChangeNotifierProvider(
      create:(context)=> dbController(),
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title:'Auction' ,
        routes: <String , WidgetBuilder>{

          '/login':(BuildContext context)=>new login(),
          '/adminhome':(BuildContext context)=>new adminHome(),
          '/userhome':(BuildContext context)=>new userHome(),
          '/addproduct':(BuildContext context)=>new addproduct(product),
          '/viewallproducts':(BuildContext context)=>new  viewallproducts(),
          '/createauction':(BuildContext context)=>new  createAuction(product),
          '/viewAuction':(BuildContext context)=>new  viewAuction(),
          '/startAuction':(BuildContext context)=>new  startAuction(auction!),
          '/adminprofile':(BuildContext context)=>new  adminProfile(),
          '/signup':(BuildContext context)=>new  signup(),
          '/viewproducts':(BuildContext context)=>new  viewproducts(),
          '/viewauctions':(BuildContext context)=>new  viewauctions(),
          '/userprofile':(BuildContext context)=>new  userprofile(),
        } ,
        home:(email==null) ? new login()
        : (email=='ahmedlord1410@gmail.com') ? new adminHome()
        : new userHome(),
      ),
  );

}