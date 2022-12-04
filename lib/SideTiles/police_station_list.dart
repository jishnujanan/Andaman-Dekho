import 'package:app/SideTiles/sort.dart';
import 'package:app/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../helpers.dart';

class PoliceStationsList extends StatefulWidget {
  const PoliceStationsList({Key? key}) : super(key: key);

  @override
  State<PoliceStationsList> createState() => _PoliceStationsListState();
}

class _PoliceStationsListState extends State<PoliceStationsList> {
  // List<Map<String, String>> police_stations = [
  //   {
  //     "name": "Police Station Ograbraj",
  //     "address":
  //         "MM57+VPG, Great Andaman Trunk Road, Ograbraj, Andaman and Nicobar Islands 744103",
  //     "number": "3192224934",
  //     "latitude": "11.659697760489312",
  //     "longitude": "92.66433454065341"
  //   },
  //   {
  //     "name": "Police Station Aberdeen",
  //     "address":
  //         "MP9R+G65, Near Tiranga Park, Aberdeen Bazar, Aberdeen, Port Blair, Andaman and Nicobar Islands 744101",
  //     "number": "03192232400",
  //     "latitude": "11.668797058052947",
  //     "longitude": "92.74065952245002"
  //   },
  //   {
  //     "name": "Police Station Pahargaon",
  //     "address":
  //         "MM57+VPG, Great Andaman Trunk Road, Ograbraj, Andaman and Nicobar Islands 744103",
  //     "number": "03192250525",
  //     "latitude": "11.60776611870148",
  //     "longitude": "92.70460962117575"
  //   },
  //   {
  //     "name": "Police Station Humphrey Gunj",
  //     "address": "HMP4+3WG, SH8, Manglutan, Andaman and Nicobar Islands 744103",
  //     "number": "03192287590",
  //     "latitude": "11.585231800978388",
  //     "longitude": "92.65733937188199"
  //   },
  //   {
  //     "name": "Police Station Bambooflat",
  //     "address":
  //         "PP38+X45, Bambooflat, SH10, Andaman and Nicobar Islands 744107",
  //     "number": "03192258411",
  //     "latitude": "11.704949337281564",
  //     "longitude": "92.7153614624616"
  //   },
  //   {
  //     "name": "Police Station Chatham",
  //     "address":
  //         "MPMF+6FQ, Foreshore Rd, Haddo, Port Blair, Andaman and Nicobar Islands 744102",
  //     "number": "03192232232",
  //     "latitude": "11.683012428508004",
  //     "longitude": "92.72372956310612"
  //   },
  //   {
  //     "name": "PS Central Crime Station",
  //     "address":
  //         "MP9R+9V4, RGT Rd, Aberdeen Bazar, Aberdeen, Port Blair, Andaman and Nicobar Islands 744101",
  //     "number": "03192232586",
  //     "latitude": "11.668377063206673",
  //     "longitude": "92.7421831186663"
  //   },
  //   {
  //     "name": "SP South Andaman District",
  //     "address":
  //         "MP7R+GRC, RGT Road, Near DC Office, Abredeen Bazaar, AHW Colony, Shadipur, Port Blair, Andaman and Nicobar Islands 744101",
  //     "number": "03192233077",
  //     "latitude": "11.66387934561577",
  //     "longitude": "92.74203241886842"
  //   },
  //   {
  //     "name": "Police Headquarter",
  //     "address":
  //         "MPFW+PG6, Atlanta Point, Port Blair, Andaman and Nicobar Islands 744104",
  //     "number": "03192232100",
  //     "latitude": "11.674263003456485",
  //     "longitude": "92.74624189188437"
  //   },
  //   {
  //     "name": "Police Station Ferrargunj",
  //     "address":
  //         "PM54+G9J, Great Andaman Trunk Rd, Ferrargunj, Andaman and Nicobar Islands 744103",
  //     "number": "0",
  //     "latitude": "11.708846834738486",
  //     "longitude": "92.65590142595559"
  //   },
  //   {
  //     "name": "Police Station | Wimberlygunj",
  //     "address": "PPR4+5R8, Wimberlygunj, Andaman and Nicobar Islands 744206",
  //     "number": "0",
  //     "latitude": "11.740425359147176",
  //     "longitude": "92.70712108721257"
  //   },
  //   {
  //     "name": "SP CID Office",
  //     "address":
  //         "MP9R+6R3, Aberdeen Bazar, Aberdeen, Port Blair, Andaman and Nicobar Islands 744101",
  //     "number": "0",
  //     "latitude": "11.668009113837957",
  //     "longitude": "92.74211885679908"
  //   },
  //   {
  //     "name": "Andaman And Nicobar Police Headquarter (PHQ)",
  //     "address": "MPFW+PF5, Unnamed Road, Atlanta Point, Port Blair, 744104",
  //     "number": "0",
  //     "latitude": "11.674261190247476",
  //     "longitude": "92.74623967517543"
  //   },
  //   {
  //     "name": "Police Complaint Authority",
  //     "address":
  //         "MP4M+5QQ, Police Line, Port Blair, Andaman and Nicobar Islands 744101",
  //     "number": "0",
  //     "latitude": "11.655452416424483",
  //     "longitude": "92.73447935300857"
  //   },
  //   {
  //     "name": "Police station Mile tilak",
  //     "address": "QMR4+V6M, Mile Tilek, Andaman and Nicobar Islands 744103",
  //     "number": "0",
  //     "latitude": "11.79220803926996",
  //     "longitude": "92.65557905040914"
  //   },
  //   {
  //     "name": "Rutland Police Station",
  //     "address": "FMQ4+H36, Andaman and Nicobar Islands 744105",
  //     "number": "0",
  //     "latitude": "11.488911004450681",
  //     "longitude": "92.65515003036731"
  //   },
  //   {
  //     "name": "Office Of Deputy Superintendent Of Police",
  //     "address": "2XRM+93M, SH4, Andaman and Nicobar Islands 744211",
  //     "number": "03192282249",
  //     "latitude": "11.04095934027433",
  //     "longitude": "92.98263718340924"
  //   },
  // ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // police_stations.sort((a, b) {
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
        iconTheme: const IconThemeData(color: setColors.white),
        elevation: 0.0,
        backgroundColor: setColors.appBar,
        title: const Text(
          "Police Stations",
          style: TextStyle(color: setColors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("policestations")
              .snapshots(),
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
                List<Map<String,dynamic>> police_stations=[];
                snapshot.data!.docs.forEach((element) {
                  police_stations.add(element.data());
                });
                police_stations = Sort.bubbleSort(police_stations);
                return Container(
                  padding: EdgeInsets.only(
                      right: width * 0.03,
                      left: width * 0.03,
                      top: height * 0.02),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: police_stations.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: index % 2 == 0
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
                          tileColor: Colors.blue.shade800,
                          shape: index % 2 == 0
                              ? const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)))
                              : const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          onTap: () async {
                            double latitude, longitude;
                            latitude = double.parse(
                                police_stations[index]['latitude']!);
                            longitude = double.parse(
                                police_stations[index]['longitude']!);
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
                                      police_stations[index]['name']!,
                                      overflow: TextOverflow.ellipsis,
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
                                  const Text(
                                    "Location : ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: setColors.white,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    width: width * 0.65,
                                    child: Text(
                                      police_stations[index]['address']!,
                                      maxLines: 3,
                                      style:  TextStyle(fontSize: 12,color: setColors.white.withOpacity(0.9),),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(""),
                              police_stations[index]['number'] != "0"
                                  ? Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Phone     : ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: setColors.white,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              width: width * 0.65,
                                              child: Text(
                                                police_stations[index]
                                                    ['number']!,
                                                maxLines: 3,
                                                style:  TextStyle(
                                                    fontSize: 14,color: setColors.white.withOpacity(0.9),),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : const SizedBox(
                                      height: 0,
                                    ),
                              police_stations[index]['number'] != "0"
                                  ? const Text("")
                                  : const SizedBox(
                                      height: 0,
                                    ),
                              Row(
                                children: [
                                  const Text(
                                    "Distance : ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: setColors.white,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    width: width * 0.65,
                                    child: Text(
                                        (Geolocator.distanceBetween(
                                                        double.parse(
                                                            police_stations[index]
                                                                ['latitude']!),
                                                        double.parse(
                                                            police_stations[index]
                                                                ['longitude']!),
                                                        currPoss.latitude,
                                                        currPoss.longitude) /
                                                    1000) >=
                                                10
                                            ? (((Geolocator.distanceBetween(double.parse(police_stations[index]['latitude']!), double.parse(police_stations[index]['longitude']!), currPoss.latitude, currPoss.longitude) + 4) / 1000)
                                                    .toStringAsFixed(3)
                                                    .toString() +
                                                " kms")
                                            : (((Geolocator.distanceBetween(
                                                                double.parse(police_stations[index]['latitude']!),
                                                                double.parse(police_stations[index]['longitude']!),
                                                                currPoss.latitude,
                                                                currPoss.longitude) +
                                                            1) /
                                                        1000)
                                                    .toStringAsFixed(3)
                                                    .toString() +
                                                " kms"),
                                        style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: setColors.white.withOpacity(0.9),)),
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
