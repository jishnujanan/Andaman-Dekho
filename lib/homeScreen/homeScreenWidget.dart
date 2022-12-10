import 'package:app/AboutUs/aboutus.dart';
import 'package:app/SideTiles/airports.dart';
import 'package:app/SideTiles/atmList.dart';
import 'package:app/SideTiles/banks.dart';
import 'package:app/SideTiles/hospitals.dart';
import 'package:app/SideTiles/pharmacy.dart';
import 'package:app/SideTiles/police_station_list.dart';
import 'package:app/TypeDetails/placeType.dart';
import 'package:app/botttomSheet/bottomSheet.dart';
import 'package:app/colors.dart';
import 'package:app/helpers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';

import '../AboutAndaman/aboutandaman.dart';
import '../query/askQuery.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isLoading = true;
  var categories = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Geolocator.checkPermission().then((permission) {
      print("permission is $permission");
      if (permission.index == 0) {
        print("Permission Denied");
        Geolocator.requestPermission().then((permission) {
          print(permission);
          setCurrPos();
          // print(permission.index);
        });
      } else if (permission.index == 2 || permission == 1) {
        print("Permission Granted");
        setCurrPos();
      }
      // print(permission.index);
    });

    Dio http = getDio();
    http
        .get(
      "https://us-central1-andaman-dekho.cloudfunctions.net/api/app/getCategory",
    )
        .then((resp) {
      setState(() {
        categories = resp.data['message'];
        print(resp.data);
        //categories.sort();
        isLoading = false;
      });
    });
  }

  void DrawerTapped() {
    Navigator.pop(context);
  }

  List<Widget> getGridWidgets() {
    List<Widget> returnVal = <Widget>[];
    for (int i = 0; i < categories.length; i++) {
      returnVal.add(ListView(padding: EdgeInsets.zero, children: const [
        Image(
          image: NetworkImage(
              "https://i0.wp.com/digital-photography-school.com/wp-content/uploads/2021/03/horizontal-lines-photography-3.jpg?w=1500&ssl=1"),
        ),
      ]));
    }
    return returnVal;
  }

  void navigateToPlaceType(place) {
    Navigator.push(
        context,
        PageTransition(
            child: PlaceType(
              placeType: place,
              categories: categories,
            ),
            type: PageTransitionType.rightToLeftJoined,
            duration: const Duration(milliseconds: 110),
            reverseDuration: const Duration(milliseconds: 110),
            childCurrent: this.widget));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: setColors.body,
        drawerDragStartBehavior: DragStartBehavior.start,
        drawerEnableOpenDragGesture: true,
        drawer: Drawer(
          backgroundColor: setColors.body,
          elevation: 0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: setHeight(context, factor: 0.15),
                width: setWidth(context, factor: 0.1),
                child: Center(child: Image.asset('assets/logo/LIGHT-LOGO.png')),
              ),
              ListTile(
                title: const Text('ATM'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AtmList(),
                      ));
                },
              ),
              ListTile(
                title: const Text('Hospital'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Hospitals(),
                      ));
                },
              ),
              ListTile(
                title: const Text('Pharmacy'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Pharmacy(),
                      ));
                },
              ),
              ListTile(
                title: const Text('Police Station'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PoliceStationsList(),
                      ));
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Bank'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Banks()));
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Airport'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Airports()));
                  // Update the state of the app.
                  // ...
                },
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 1,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text('About Andaman'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutAndaman(),
                      ));
                },
              ),
              ListTile(
                title: const Text('About Us'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Aboutus(),
                      ));

                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Review Us'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const bottomSheet(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: setColors.white),
          elevation: 0.0,
          backgroundColor: setColors.appBar,
          title: Text(
            "Dekho Andaman",
            style: TextStyle(color: setColors.white.withOpacity(0.9)),
          ),
        ),
        body: isLoading
            ? getLoadingWidget()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: (categories.length / 2).ceil(),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var ind1 = index * 2;
                        var ind2 = index * 2 + 1;
                        print(ind1);
                        return Column(
                          children: [
                            SizedBox(
                              height:
                              setHeight(context, factor: 0.01),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    navigateToPlaceType(
                                        categories[ind1]['categoryName']);
                                  },
                                  child: Card(
                                    color: setColors.body,
                                    elevation: 0,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height:
                                              setHeight(context, factor: 0.17),
                                          width:
                                              setWidth(context, factor: 0.44),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            child: Image(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  categories[ind1]
                                                      ['categoryImageLink'],
                                                ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              setHeight(context, factor: 0.01),
                                        ),
                                        SizedBox(
                                          width:
                                              setWidth(context, factor: 0.45),
                                          child: Center(
                                            child: Text(
                                              categories[ind1]['categoryName'],
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: setColors.black
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              setHeight(context, factor: 0.005),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                //Second Type in Same Row
                                ind2 > categories.length - 1
                                    ? InkWell(
                                      onTap: () {},
                                      child: Card(
                                        color: setColors.body,
                                        elevation: 0,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: setHeight(context,
                                                  factor: 0.17),
                                              width: setWidth(context,
                                                  factor: 0.44),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: const Text(" ")),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              " ",
                                              style: TextStyle(
                                                  color: setColors.black
                                                      .withOpacity(0.8),
                                                  fontWeight:
                                                      FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                    : InkWell(
                                        onTap: () {
                                          print(categories[ind2]['categoryName']);
                                          navigateToPlaceType(
                                              categories[ind2]['categoryName']);
                                        },
                                        child: Card(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: setHeight(context,
                                                    factor: 0.17),
                                                width: setWidth(context,
                                                    factor: 0.44),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  child: Image(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        categories[ind2][
                                                            'categoryImageLink']),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: setHeight(context,
                                                    factor: 0.01),
                                              ),
                                              SizedBox(
                                                width: setWidth(context,
                                                    factor: 0.45),
                                                child: Center(
                                                  child: Text(
                                                    categories[ind2]
                                                        ['categoryName'],
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: setColors.black
                                                            .withOpacity(0.6),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: setHeight(context,
                                                    factor: 0.005),
                                              ),
                                            ],
                                          ),
                                          elevation: 0,
                                        ),
                                        splashColor: setColors.white,
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: setHeight(context, factor: 0.025),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ));
  }
}
