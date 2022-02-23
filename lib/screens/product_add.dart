import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }

}

class ProductAddState  extends State{

  DbHelper dbHelper= DbHelper();

  TextEditingController txtName= TextEditingController();
  TextEditingController txtDescription= TextEditingController();
  TextEditingController txtUnitPrice= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Ürün Ekle"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

 Widget buildNameField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Ürün Adı",
      ),
      controller: txtName,
    );
 }

 Widget buildDescriptionField() {
   return TextField(
     decoration: InputDecoration(
       labelText: "Ürün Açıklama",
     ),
     controller: txtDescription,
   );
 }

 Widget buildUnitPriceField() {
   return TextField(
     decoration: InputDecoration(
       labelText: "Birim Fiyatı",
     ),
     controller: txtUnitPrice,
   );
 }

 Widget buildSaveButton() {
    return FlatButton(
        onPressed: () {
          addProduct();
        },
        child: Text("Ekle"));
 }

  void addProduct() async{
   var result= await dbHelper.insert(Product(txtName.text, txtDescription.text, double.parse(txtUnitPrice.text)));
    Navigator.pop(context,true);
  }
}