import 'package:app/colors.dart';
import 'package:flutter/material.dart';

import '../helpers.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = setHeight(context, factor: 1);
    double width = setWidth(context, factor: 1);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        automaticallyImplyLeading: true,
        backgroundColor: setColors.appBar,
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: height * 0.2,
                child: Image.asset('assets/logo/LIGHT-LOGO.png'),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
