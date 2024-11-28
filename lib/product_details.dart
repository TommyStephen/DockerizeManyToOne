import 'package:flutter/material.dart';
import 'package:product_demo/model/product_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel? product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // Function to open the link
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url); // Convert string to URI
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri); // Opens the link in the browser
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/images/${widget.product?.productImagePath}"),
                radius: 75,
              ),
              SizedBox(height: 10),
              Text(widget.product!.productName!,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              SizedBox(height: 10),
              Text(widget.product!.productDescription!,
                  style: TextStyle(
                    fontSize: 30,
                  )),
              SizedBox(height: 10),
              Text(
                "Price : ${widget.product!.price!.toString()} per ${widget.product!.uom}",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Social Media Link: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => _launchURL(
                          widget.product!.productSocialMedia!.socialMediaLink),
                      child: Text(
                        widget.product!.productSocialMedia!.socialMediaLink,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Allergy Name: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    widget.product!.productAllergy!.allergyName,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              const Text(
                "Allergy Description: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      widget.product!.productAllergy!.allergyDescription,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              const Text(
                "Allergy Link: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => _launchURL(
                          widget.product!.productAllergy!.allergyLink),
                      child: Text(
                        widget.product!.productAllergy!.allergyLink,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
