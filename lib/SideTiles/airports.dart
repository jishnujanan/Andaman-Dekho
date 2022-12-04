import 'package:app/SideTiles/sort.dart';
import 'package:app/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/helpers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../helpers.dart';

class Airports extends StatefulWidget {
  const Airports({Key? key}) : super(key: key);

  @override
  State<Airports> createState() => _AirportsState();
}

class _AirportsState extends State<Airports> {
  // List<Map<String, String>> airports = [
  //   {
  //     "name": "Veer Savarkar International Airport",
  //     "address":
  //         "MP2M+36H, Lamba Line, Port Blair, Andaman and Nicobar Islands 744103",
  //     "latitude": "11.650299139077667",
  //     "longitude": "92.73288899056733"
  //   }
  // ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // airports.sort((a, b) {
    //   return Geolocator.distanceBetween(
    //           double.parse(a['latitude']!),
    //           double.parse(a['longitude']!),
    //           currPoss.latitude,
    //           currPoss.longitude)
    //       .toDouble()
    //       .toString()
    //       .compareTo(Geolocator.distanceBetween(
    //               double.parse(b['latitude']!),
    //               double.parse(b['longitude']!),
    //               currPoss.latitude,
    //               currPoss.longitude)
    //           .toDouble()
    //           .toString());
    // });
    double height = setHeight(context, factor: 1);
    double width = setWidth(context, factor: 1);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color:setColors.white,),
        elevation: 0.0,
        backgroundColor: setColors.appBar,
        title: const Text(
          "Airport",
          style: TextStyle(color: setColors.white,),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection("airports").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[CircularProgressIndicator()],
                ),
              );
            } else {
              if (snapshot.data!.docs.isNotEmpty) {
                List<Map<String,dynamic>> airports=[];
                for (var element in snapshot.data!.docs) {
                  airports.add(element.data());
                }
                //airports = Sort.bubbleSort(airports);
                airports.sort((a, b) {
                  return Geolocator.distanceBetween(
                          double.parse(a['latitude']!),
                          double.parse(a['longitude']!),
                          currPoss.latitude,
                          currPoss.longitude)
                      .toDouble()
                      .toString()
                      .compareTo(Geolocator.distanceBetween(
                              double.parse(b['latitude']!),
                              double.parse(b['longitude']!),
                              currPoss.latitude,
                              currPoss.longitude)
                          .toDouble()
                          .toString());
                });
                return Container(
                  padding: EdgeInsets.only(
                      right: width * 0.03,
                      left: width * 0.03,
                      top: height * 0.02),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: airports.length,
                    itemBuilder: (context, index) {
                      return Card(shape: index % 2 == 0
                          ? const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20)))
                          : const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                        elevation: 10,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: width * 0.04,
                              vertical: height * 0.01),
                          shape: index % 2 == 0
                              ? const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)))
                              : const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          tileColor:setColors.blue.shade800,
                          onTap: () async {
                            double latitude, longitude;
                            latitude =
                                double.parse(airports[index]['latitude']!);
                            longitude =
                                double.parse(airports[index]['longitude']!);
                            MapUtils.openMap(latitude, longitude);
                            MapsLauncher.launchCoordinates(latitude, longitude);
                            // await FirebaseFirestore.instance.collection('atms').add(atms[index]);
                          },
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(""),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.7,
                                    child: Text(
                                      airports[index]['name']!,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: setColors.white,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const Text("    "),
                                ],
                              ),
                              const Text(""),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    "Location : ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: setColors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    width: width * 0.65,
                                    child: Text(
                                      airports[index]['address']!,
                                      maxLines: 3,
                                      style: const TextStyle(fontSize: 13,color: setColors.white,),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(""),
                              Row(
                                children: [
                                  Text(
                                    "Distance : ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: setColors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    width: width * 0.65,
                                    child: Text(
                                        (Geolocator.distanceBetween(
                                                        double.parse(
                                                            airports[index]
                                                                ['latitude']!),
                                                        double.parse(
                                                            airports[index]
                                                                ['longitude']!),
                                                        currPoss.latitude,
                                                        currPoss.longitude) /
                                                    1000) >=
                                                10
                                            ? (((Geolocator.distanceBetween(double.parse(airports[index]['latitude']!), double.parse(airports[index]['longitude']!), currPoss.latitude, currPoss.longitude) + 4) / 1000)
                                                    .toStringAsFixed(3)
                                                    .toString() +
                                                " kms")
                                            : (((Geolocator.distanceBetween(
                                                                double.parse(airports[index]['latitude']!),
                                                                double.parse(airports[index]['longitude']!),
                                                                currPoss.latitude,
                                                                currPoss.longitude) +
                                                            1) /
                                                        1000)
                                                    .toStringAsFixed(3)
                                                    .toString() +
                                                " kms"),
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: setColors.white,)),
                                  ),
                                ],
                              ),
                              const Text(""),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    "No data",
                  ),
                );
              }
            }
          }),
    );
  }
}
