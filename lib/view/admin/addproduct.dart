import 'package:auction/controller/Utility.dart';
import 'package:auction/controller/admincontroller.dart';
import 'package:auction/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class addproduct extends StatefulWidget {
  final Product product;
  addproduct(this.product);
  @override
  State<StatefulWidget> createState() {
    return addproductstate();
  }


}
class addproductstate extends State <addproduct> {
  TextEditingController _productname = new TextEditingController();
  TextEditingController _producttype = new TextEditingController();
  TextEditingController _productprice = new TextEditingController();
  TextEditingController _productimage = new TextEditingController();
  TextEditingController _productdescription = new TextEditingController();

  String error = '';
  String imgString = '';
  adminController admindb= new adminController();

  void bottombar(int x) {
    if (x == 0) {
      Navigator.of(context).pushReplacementNamed('/adminhome');
    }
    else {
      Navigator.of(context).pushReplacementNamed('/adminprofile');
    }
  }
  void pickupImage() async{
    final ImagePicker picker = ImagePicker();

    picker.getImage(source: ImageSource.gallery).then(( imgFile) async {
      if(imgFile==null) setState(() =>error='no image data');
      else{
        imgString = Utility.base64String(await imgFile.readAsBytes());
        _productimage.text=imgString;

      }

    });
  }
  void update()async{
    if(_productname.text.isEmpty||_producttype.text.isEmpty||_productimage.text.isEmpty||_productprice.text.isEmpty||_productdescription.text.isEmpty) {
      setState(() {
        error='fill requirements';
      });
    }
    else {
      await admindb.updateProduct(widget.product.id,
          _productname.text, _producttype.text, int.parse(_productprice.text),
          _productimage.text,_productdescription.text);
      setState(() {
        error=admindb.errorAddingProduct;
      });
      Navigator.of(context).pushReplacementNamed('/viewallproducts');

    }

  }
  void add()async{

      if(_productname.text.isEmpty||_producttype.text.isEmpty||_productimage.text.isEmpty||_productprice.text.isEmpty||_productdescription.text.isEmpty) {
        setState(() {
          error='fill requirements';
        });
      }
      else {
       await admindb.addproduct(
            _productname.text, _producttype.text, int.parse(_productprice.text),
            _productimage.text,_productdescription.text);
        setState(() {
          error=admindb.errorAddingProduct;
        });
       Navigator.of(context).pushReplacementNamed('/viewallproducts');

      }
  }
  @override
  void initState() {
    super.initState();
    if(widget.product.id!=''){
     _productname = new TextEditingController(text: widget.product.name);
     _producttype = new TextEditingController(text: widget.product.type);
     _productprice = new TextEditingController(text:widget.product.price.toString());
     _productimage = new TextEditingController(text: widget.product.image);
     _productdescription=new TextEditingController(text: widget.product.description);
  }
    }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title:(widget.product.id=='') ? new Text('New product', style: TextStyle(
            color: Colors.white,
            fontSize: 25
        ),
        )
            : new Text('Update ${widget.product.name}', style: TextStyle(
            color: Colors.white,
            fontSize: 25
        ),
        )
      ),
      body: new Container(
        padding: EdgeInsets.all(20),
        child: new ListView(
          children: [
            new TextField(
              controller: _productname,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black54,
              decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  icon: new Icon(Icons.edit,
                    color: Colors.redAccent,),
                  labelText: 'Product Name',
                  labelStyle: TextStyle(
                      color: Colors.orangeAccent, fontSize: 20)),
            ),
            new TextField(
              controller: _producttype,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black54,
              decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  icon: new Icon(Icons.error,
                    color: Colors.redAccent,),
                  labelText: 'Product type',
                  labelStyle: TextStyle(
                      color: Colors.orangeAccent, fontSize: 20)),
            ),
            new TextField(
              controller: _productprice,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black54,
              decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  icon: new Icon(Icons.monetization_on_outlined,
                    color: Colors.redAccent,),
                  labelText: 'Product price',
                  labelStyle: TextStyle(
                      color: Colors.orangeAccent, fontSize: 20)),
            ),
            new Padding(padding: EdgeInsets.only(top: 10)),
            new Row(
              children: [
                new SizedBox(
                  width: 250,
                  height: 100,
                  child: new TextField(
                    controller: _productimage,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black54,
                    decoration: new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)),
                        icon: new Icon(Icons.image,
                          color: Colors.redAccent,),
                        labelText: 'Product image',
                        labelStyle: TextStyle(
                            color: Colors.orangeAccent, fontSize: 20)),
                  ),
                ),

                Expanded(child: new IconButton(
                    icon: Icon(Icons.add,color: Colors.black,),
                    onPressed: pickupImage
                ),
                ),


              ],
            ),
        new TextField(
                controller: _productdescription,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black54,
                maxLines: 5,
                minLines: 3,
                decoration: new InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    icon: new Icon(Icons.format_indent_decrease,
                      color: Colors.redAccent,),
                    labelText: 'Product description',
                    labelStyle: TextStyle(
                        color: Colors.orangeAccent, fontSize: 20)),
              ),
            (widget.product.id!='') ?
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new SizedBox(
                  height: 100,
                  width: 100,
                  child: Utility.imageFromBase64String(_productimage.text),
                )
              ],
            )
            : Text(''),

            new Text('$error',
              style: TextStyle(
                color: Colors.red.shade800,
                fontSize: 14,
              ),
            ),
            new Padding(padding: EdgeInsets.only(bottom: 50),),
            new RaisedButton(onPressed:(widget.product.id=='') ? add
              : update,

              color: Colors.red,
              child: (widget.product.id=='') ? new Text('ADD',
                style: TextStyle(color: Colors.white,
                    fontSize: 16

                ),
              )
              : new Text('Update',
                style: TextStyle(color: Colors.white,
                    fontSize: 16

                ),
              )
            )

          ],
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home, color: Colors.orangeAccent),
              title: new Text('HOME',
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey))),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.account_box, color: Colors.orangeAccent,),
              title: new Text('PROFILE',
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey))),
        ],
        onTap: bottombar,
        type: BottomNavigationBarType.fixed,
      ),


    );
  }

}