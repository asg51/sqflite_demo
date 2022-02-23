import 'package:sqflite_demo/main.dart';

class Product{
  int id=0;
  String name="";
  String description="";
  double unitprice=0.0;

  Product(this.name,this.description, this.unitprice);
  Product.withId(this.id,this.name,this.description,this.unitprice);

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map= Map<String,dynamic>();
    map["name"]=name;
    map["description"]=description;
    map["unitprice"]=unitprice;

        map["id"]=id;

    return map;
  }

  Product.fromObject(dynamic o){
    this.id=o["id"]!;
    this.name=o["name"];
    this.description=o["description"];
    this.unitprice=double.tryParse(o["unitPrice"].toString())!;
  }
}