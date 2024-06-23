import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PaymentMethodView extends GetView {
  const PaymentMethodView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentMethodView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentMethodView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
