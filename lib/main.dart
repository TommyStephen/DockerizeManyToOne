import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:product_demo/category_form.dart';
import 'package:product_demo/model/product_category_model.dart';
import 'package:product_demo/model/product_model.dart';
import 'package:product_demo/product_details.dart';
import 'package:product_demo/product_form.dart';
import 'package:http/http.dart' as http;
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MaterialApp(
    title: "ManyToOne",
    home: const MyHomePage(),
    routes: {
      '/home': (context) {
        final ProductModel product =
            ModalRoute.of(context)!.settings.arguments as ProductModel;
        return MyHomePage(savedProduct: product);
      },
      '/createCategory': (context) => CategoryForm(),
      '/createProduct': (context) {
        final ProductCategoryModel category =
            ModalRoute.of(context)!.settings.arguments as ProductCategoryModel;
        return ProductForm(category: category);
      },
      '/productDetails': (context) {
        final ProductModel product =
            ModalRoute.of(context)!.settings.arguments as ProductModel;
        return ProductDetails(product: product);
      },
    },
  ));
}

class MyHomePage extends StatefulWidget {
  final ProductModel? savedProduct;
  const MyHomePage({
    super.key,
    this.savedProduct,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductModel> productList = [];

  @override
  initState() {
    super.initState();
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('ManyToOne App'),
          bottom: const TabBar(
            indicator: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.symmetric(
                horizontal: BorderSide(color: Colors.white),
                vertical: BorderSide(color: Colors.white),
              ),
            ),
            isScrollable: true,
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'AddProduct'),
              Tab(text: 'AddCategory'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/Batsman.jpg"),
                  radius: 70,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      var product = productList[index];
                      return Card(
                        child: ListTile(
                          leading: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/productDetails",
                                  arguments: product);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: EdgeInsets.zero,
                            ),
                            child: CircleAvatar(
                              backgroundImage:
                                  MemoryImage(base64Decode(product.image!)),
                            ),
                          ),
                          title: Text(product.productName!),
                          subtitle: Text(
                              "Price : ${product.price} per ${product.uom}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Center(
              child: ProductForm(
                  category: ProductCategoryModel(id: 0, categoryName: '')),
            ),
            Center(
              child: CategoryForm(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getProductList() async {
    var response = await http
        .get(Uri.parse('http://localhost:8080/api/product/getAllProducts'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body) as List;
      setState(() {
        productList =
            jsonData.map((item) => ProductModel.fromJson(item)).toList();
      });
    }
  }
}
