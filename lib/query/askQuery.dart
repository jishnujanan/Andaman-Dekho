import 'package:app/botttomSheet/bottomSheet.dart';
import 'package:app/colors.dart';
import 'package:flutter/material.dart';

import '../helpers.dart';
class AskQuery extends StatefulWidget {
  const AskQuery({Key? key}) : super(key: key);

  @override
  State<AskQuery> createState() => _AskQueryState();
}

class _AskQueryState extends State<AskQuery> {
  String? email,query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: setColors.appBar,
        title: const Text(
          "Ask Query"
          ,style: TextStyle(color: Colors.black),
        ),
      ),
      bottomSheet: bottomSheet(),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: setWidth(context,factor: 0.08),vertical: setHeight(context,factor: 0.04)),
        child: Column(
          children:  [
            TextFormField(
              onChanged: (value) {
                email=value;
              },

              decoration: InputDecoration(
                isDense: false,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                hintText: "Enter your Email",
                hintStyle:  TextStyle(color: setColors.black.withOpacity(0.6)),
                filled: true,
                fillColor: Colors.grey[300],
              ),
            ),
            const Text("\n"),
            TextFormField(
              onChanged: (value) {
                query=value;
              },
              maxLines: 6,
              decoration: InputDecoration(
                isDense: false,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                hintText: "Ask queries",
                hintStyle:  TextStyle(color: setColors.black.withOpacity(0.6)),
                filled: true,
                fillColor: Colors.grey[300],
              ),
            ),
            const Text("\n"),
            MaterialButton(onPressed: () {},child: const Text("Submit",style: TextStyle(color: setColors.blue),),)
          ],
        ),
      ),
    );
  }
}
