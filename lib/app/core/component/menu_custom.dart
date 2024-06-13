import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuCustom extends StatelessWidget {
  const MenuCustom({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.routeName,
  }) : super(key: key);

  final String title;
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
        width: 120,
        height: 137,
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: 120,
                height: 137,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'YourFontFamily',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                height: 84,
                width: 84,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _imageUrl(imageUrl),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _imageUrl(String imageName) {
  return Image.asset("images/$imageName", fit: BoxFit.fill);
}
