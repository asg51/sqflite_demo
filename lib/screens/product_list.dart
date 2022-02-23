import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';
import 'package:sqflite_demo/screens/product_add.dart';
import 'package:sqflite_demo/screens/product_detail.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductListState();
  }
}

class _ProductListState extends State {
  var dbHelper = DbHelper();
  List<Product>? products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  // @override
  // void setState(VoidCallback fn) {
  //  var productsFuture= dbHelper.getProducts();
  //  productsFuture.then((value) {
  //    this.products=value;
  //    this.productCount=value.length;
  //  });
  //   super.setState(fn);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Yeni Ürün Ekle",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
      itemCount: productCount,
      itemBuilder: (context, index) {
        return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black12,
                child: Text("P"),
              ),
              title: Text(this.products![index].name),
              subtitle: Text(this.products![index].description),
              onTap: () {
                goToDetail(this.products![index]);
              },
            ));
      },
    );
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if(result!=null){
      if(result==true){
        getProducts();
      }
    }
  }
  void getProducts(){
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((value) {
      setState(() {
        this.products = value;
        this.productCount = value.length;
      });
    });
  }

  void goToDetail(Product product) async{
    bool result= await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product),));
    if(result!=null)
      {
        if(result){
          getProducts();
        }
      }
  }
}
