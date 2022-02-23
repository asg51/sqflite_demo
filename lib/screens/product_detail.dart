import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options { delete, update }

class _ProductDetailState extends State {
  DbHelper dbHelper= DbHelper();

  TextEditingController txtName= TextEditingController();
  TextEditingController txtDescription= TextEditingController();
  TextEditingController txtUnitPrice= TextEditingController();

  Product product;
  _ProductDetailState(this.product);

  @override
  void initState() {
    txtName.text=product.name;
    txtDescription.text=product.description;
    txtUnitPrice.text=product.unitprice.toString();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Detayı : ${product.name}"),
        actions: [
          PopupMenuButton<Options>(
            onSelected: selectedProcess,
              itemBuilder: (context) => <PopupMenuEntry<Options>>[
                    PopupMenuItem<Options>(
                      child: Text("Sil"),
                      value: Options.delete,
                    ),
                PopupMenuItem<Options>(
                  child: Text("Güncelle"),
                  value: Options.update,
                )
                  ])
        ],
      ),
      body: buildProductDetail(),
    );
  }

  Widget buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: [
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField(),
        ],
      ),
    );
  }

  void selectedProcess(Options value) async{
    switch(value){
      case Options.delete:{
        await dbHelper.delete(product.id);
        Navigator.pop(context,true);
        break;
      }
      case Options.update:{

      product.name=txtName.text;
      product.unitprice=double.tryParse(txtUnitPrice.text)!;
      product.description=txtDescription.text;
      await dbHelper.update(product);

      Navigator.pop(context,true);
        break;
      }
      default:{
        break;
      }
    }
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
}
