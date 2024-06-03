import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package for navigation

class MenuCustom2 extends StatelessWidget {
  const MenuCustom2({
    Key? key,
    required this.title,
    // required this.bgColor,
    required this.imageUrl,
    required this.routeName,
  }) : super(key: key); // Add key parameter to the constructor

  final String title;
  // final List<Color> bgColor;
  final String imageUrl;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
            routeName); // Navigate to the specified routeName when tapped
      },
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 300,
        height: 93,
        child: Stack(
          children: [
            Card(
              margin: const EdgeInsets.only(top: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: 300,
                height: 70,
                padding: const EdgeInsets.only(left: 40),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'YourFontFamily',
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: bgColor,
                  // ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _imageUrl(
                    imageUrl), // Call the _imageUrl method to load the image
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageUrl(String imageName) {
    return Image.asset(
      "images/$imageName",
      fit: BoxFit.cover,
    );
  }
}
