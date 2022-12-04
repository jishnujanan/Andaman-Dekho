import 'package:app/colors.dart';
import 'package:app/homeScreen/homeScreenWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../helpers.dart';
import '../query/askQuery.dart';
class bottomSheet extends StatefulWidget {
  const bottomSheet();

  @override
  State<bottomSheet> createState() => _bottomSheetState();
}

class _bottomSheetState extends State<bottomSheet> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    double height=setHeight(context,factor: 1);
    double width=setWidth(context,factor: 1);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:  width*0.04, vertical: height*0.01),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: width*0.03, vertical: height*0.013),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs:  [
              GButton(
                icon:LineIcons.home,
                text: 'Home',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                  //print('called on tap');
                },
              ),
              GButton(
                icon: LineIcons.hotel,
                text: 'Hotels',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12.0)), //this right here
                        child: SizedBox(
                          height: setHeight(context, factor: 0.15),
                          width: setWidth(context, factor: 0.5),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Will update Soon',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ));
                  //print('called on tap');
                },
              ),
              GButton(
                icon: LineIcons.car,
                text: 'Cab Rental',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12.0)), //this right here
                        child: SizedBox(
                          height: setHeight(context, factor: 0.15),
                          width: setWidth(context, factor: 0.5),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Will update Soon',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ));
                  //print('called on tap');
                },
              ),
              GButton(
                icon: LineIcons.plane,
                text: 'Adventure',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12.0)), //this right here
                        child: SizedBox(
                          height: setHeight(context, factor: 0.15),
                          width: setWidth(context, factor: 0.5),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Will update Soon',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ));
                  //print('called on tap');
                },
              ),
              GButton(
                icon: LineIcons.question,
                text: 'Ask Query',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AskQuery(),));
                  //print('called on tap');
                },
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
