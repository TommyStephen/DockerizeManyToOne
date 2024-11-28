import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:product_demo/model/product_category_model.dart';
import 'package:product_demo/model/product_model.dart';

class ProductForm extends StatefulWidget {
  final ProductCategoryModel category;

  ProductForm({required this.category});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  late ProductCategoryModel category;
  late ProductModel savedProduct;

  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  ProductCategoryModel? selectedCategory;
  List<ProductCategoryModel> categoryList = [];

  //product specific properties to return response
  TextEditingController productNameControler = TextEditingController();
  TextEditingController productLocalNameControler = TextEditingController();
  String productDescription = '';
  TextEditingController productDescriptionControler = TextEditingController();
  double price = 0;
  TextEditingController uomControler = TextEditingController();
  int? categoryId;
  TextEditingController socialMediaLinkControler = TextEditingController();
  TextEditingController allergyNameControler = TextEditingController();
  TextEditingController allergyDescriptionControler = TextEditingController();
  TextEditingController allergyLinkControler = TextEditingController();

  //File picker related variables
  final FilePicker picker = FilePicker.platform;
  PlatformFile? selectedFile;

  @override
  initState() {
    super.initState();
    getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, bottom: 50),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 170,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape:
                          const CircleBorder(), // Circular shape for the button
                      padding: EdgeInsets.zero, // Removes extra padding
                    ),
                    onPressed: () {
                      pickImage();
                    },
                    child: CircleAvatar(
                      radius: 85,
                      child: ClipOval(
                        child: selectedFile == null
                            ? const Text('Select Image')
                            : kIsWeb
                                ? Image.memory(
                                    selectedFile!.bytes!,
                                    fit: BoxFit.cover,
                                    width:
                                        170, // Width should match the size of CircleAvatar
                                    height:
                                        170, // Height should match the size of CircleAvatar
                                  )
                                : Image.file(
                                    File(selectedFile!.path!),
                                    fit: BoxFit.cover,
                                    width: 170,
                                    height: 170,
                                  ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DropdownButtonFormField<ProductCategoryModel>(
                      decoration: const InputDecoration(
                        labelText: 'Select Category',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                      value: selectedCategory, // Current selected value
                      items: categoryList.map((ProductCategoryModel model) {
                        return DropdownMenuItem<ProductCategoryModel>(
                          value: model,
                          child: Text("${model.id}   ${model.categoryName}"),
                        );
                      }).toList(),
                      onChanged: (ProductCategoryModel? newValue) {
                        setState(() {
                          selectedCategory = newValue;
                          categoryId =
                              selectedCategory?.id!; // Update selected value
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              createStringField(
                  label: "Product Name", controller: productNameControler),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 15),
              createStringField(
                  label: "Product Local Name",
                  controller: productLocalNameControler),
              const SizedBox(height: 15),
              createStringField(
                  label: "Product Description",
                  controller: productDescriptionControler),
              const SizedBox(height: 15),
              TextFormField(
                keyboardType:
                    TextInputType.number, // Sets the keyboard to number type
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter
                      .digitsOnly, // Allows only digits (0-9)
                ],
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                onSaved: (value) => price = double.parse(value!),
              ),
              const SizedBox(height: 15),
              createStringField(
                  label: "Unit of Measurement", controller: uomControler),
              const SizedBox(height: 15),
              const Text("Social Media Link",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 15),
              createStringField(
                  label: "Social Media Link",
                  controller: socialMediaLinkControler),
              const SizedBox(height: 15),
              const Text("Allergic Details",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 15),
              createStringField(
                  label: "Product Allergy Name",
                  controller: allergyNameControler),
              const SizedBox(height: 15),
              createStringField(
                  label: "Allergy Description",
                  controller: allergyDescriptionControler),
              const SizedBox(height: 15),
              createStringField(
                  label: "Allergy Link", controller: allergyLinkControler),
              const SizedBox(height: 20),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 1, 45, 3),
                      // Background color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField createStringField({
    String? label,
    TextEditingController? controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  Future<void> getCategoryList() async {
    var response =
        await http.get(Uri.parse('http://localhost:8080/api/category/findAll'));

    if (response.statusCode == 200) {
      // Decode the response and parse it into a list of ProductCategoryModel
      var jsonData = json.decode(response.body) as List;
      setState(() {
        categoryList = jsonData
            .map((item) => ProductCategoryModel.fromJson(item))
            .toList();
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:8080/api/product/createProduct'),
      );

      if (kIsWeb) {
        // For Web
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            selectedFile!.bytes!,
            filename: selectedFile!.name,
          ),
        );
      } else {
        // For Mobile
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            selectedFile!.path!,
          ),
        );
      }

      // Add other form fields
      request.fields['productName'] = productNameControler.text;
      request.fields['productLocalName'] = productLocalNameControler.text;
      request.fields['productDescription'] = productDescriptionControler.text;
      request.fields['price'] = price.toString();
      request.fields['uom'] = uomControler.text;
      request.fields['categoryId'] = categoryId.toString();
      request.fields['socialMediaLink'] = socialMediaLinkControler.text;
      request.fields['allergyName'] = allergyNameControler.text;
      request.fields['allergyDescription'] = allergyDescriptionControler.text;
      request.fields['allergyLink'] = allergyLinkControler.text;

      // Send request
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        // Parse response into ProductModel and update the state
        setState(() {
          savedProduct = ProductModel.fromJson(jsonResponse);
        });
        print('Product created successfully: ${savedProduct.productName}');
        Navigator.pushNamed(
          context,
          "/home",
          arguments: savedProduct,
        );
      } else {
        print('Failed to create Product: ${response.statusCode}');
      }
    }
  }

  // Function to pick an image
  Future<void> pickImage() async {
    var result = await picker.pickFiles(type: FileType.image, withData: kIsWeb);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }
}
