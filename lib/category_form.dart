import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_demo/model/product_category_model.dart';

class CategoryForm extends StatefulWidget {
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();

  String categoryName = '';
  ProductCategoryModel? category;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        if (categoryName.isEmpty) {
          print('Category name is required');
          return;
        }
        // Create the request body
        Map<String, dynamic> requestBody = {
          'categoryName': categoryName,
        };

        // Send the HTTP POST request
        var response = await http.post(
          Uri.parse('http://localhost:8080/api/category/addCategory'),
          headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest'
          },
          body: json.encode(requestBody), // Encode request body to JSON
        );

        // Check for success
        if (response.statusCode == 200) {
          setState(() {
            var responseBody = json.decode(response.body);
            category = ProductCategoryModel.fromJson(
                responseBody); // Map the response to the model
            categoryName = category!.categoryName;
            print("Created $categoryName");
          });
        } else {
          print('Failed to create Category: ${response.statusCode}');
        }
      } catch (error) {
        print('Error occurred while creating category: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Category')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 300,
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter Category Name'),
                  onSaved: (value) => categoryName = value!,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await _submitForm(); // Call _submitForm() correctly
                    if (category != null) {
                      // Check if the category was created successfully
                      Navigator.pushNamed(
                        context,
                        '/createProduct',
                        arguments:
                            category, // Pass the category object directly
                      );
                    } else {
                      // Optionally show an error message or handle the null case
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to create category.')),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
