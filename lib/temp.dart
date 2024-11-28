// import 'package:flutter/material.dart';
// import 'package:product_demo/category_form.dart';
// import 'package:product_demo/home.dart';
// import 'package:product_demo/model/product_category_model.dart';
// import 'package:product_demo/model/product_model.dart';
// import 'package:product_demo/product_details.dart';
// import 'package:product_demo/product_form.dart';

// void main() {
//   runApp(MaterialApp(
//     title: "ManyToOne",
//     home: MyHomePage(),
//     routes: {
//       '/home': (context) => Home(),
//       '/createCategory': (context) => CategoryForm(),
//       '/createProduct': (context) {
//         final ProductCategoryModel category = ModalRoute.of(context)!
//                 .settings
//                 .arguments
//             as ProductCategoryModel; // Ensure this is directly as ProductCategoryModel
//         return ProductForm(category: category);
//       },
//       '/productDetails': (context) {
//         final ProductModel product =
//             ModalRoute.of(context)!.settings.arguments as ProductModel;
//         return ProductDetails(product: product);
//       },
//     },
//   ));
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     super.key,
//   });
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }



// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.blue,
//           bottom: const PreferredSize(
//             preferredSize: Size.fromHeight(0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: TabBar(
//                 indicator: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                   border: Border.symmetric(
//                     horizontal: BorderSide(color: Colors.white),
//                     vertical: BorderSide(color: Colors.white),
//                   ),
//                 ),
//                 isScrollable: true,
//                 tabs: [
//                   Tab(text: 'Home'),
//                   Tab(text: 'AddProduct'),
//                   Tab(text: 'AddCategory'),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: TabBarView(children: [
//           const Center(child: Home()),
//           Center(
//               child: ProductForm(
//                   category: ProductCategoryModel(id: 0, categoryName: ''))),
//           Center(child: CategoryForm()),
//         ]),
//       ),
//     );
//   }
// }
