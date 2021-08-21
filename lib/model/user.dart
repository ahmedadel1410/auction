import 'package:firebase_database/firebase_database.dart';

class User {
  String id='';
  String firstName='';
  String lastName='';
  String email='';
  String password='';
  String gender='';
  String? photo;

  User({required this.firstName,required this.lastName,required this.email,
    required this.password, required this.gender});
User.map(dynamic object){
    this.id=object['id'];
    this.firstName=object['firstName'];
    this.lastName=object['lastName'];
    this.email=object['email'];
    this.password=object['password'];
    this.gender=object['gender'];
    this.photo=object['photo'];

}
  String get getid => id ;
  String get getfname => firstName;
  String get getlname => lastName;
  String get getemail => email;
  String get getpassword => password;
  String get getgender => gender;
  String? get getphoto => photo;



  User.fromSnapShot(DataSnapshot snapShot ){
    this.id=snapShot.key!;
    this.firstName=snapShot.value['firstName'];
    this.lastName=snapShot.value['lastName'];
    this.email=snapShot.value['email'];
    this.password=snapShot.value['password'];
    this.gender=snapShot.value['gender'];
    if(photo!=null) this.photo=snapShot.value['photo'];
  }
}