import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class menu_custom2 extends StatelessWidget {
  const menu_custom2({
    super.key,
    required this.title,
    required this.bgColor,
    required this.imageUrl,
    required this.routeName
  });

  final String title;
  final List<Color> bgColor;
  final String imageUrl;
  final String routeName;
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(routeName);
      },
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 250,
        height: 70,
        child: Stack(
          children: [
            Card(
              margin: const EdgeInsets.only(top: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: 250,
                height: 50,
                padding: const EdgeInsets.only(left: 40, bottom: 15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(title),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Stack(
                children: [Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: bgColor),
                        border: Border.all(
                          width: 5,
                          color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: _imageUrl(imageUrl)
                    ),]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_imageUrl (String imageName){
  return Image.asset("images/$imageName", fit: BoxFit.cover,);
}