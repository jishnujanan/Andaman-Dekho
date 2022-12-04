import 'package:app/SideTiles/sort.dart';
import 'package:app/colors.dart';
import 'package:app/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';

class AtmList extends StatefulWidget {
  const AtmList({Key? key}) : super(key: key);

  @override
  State<AtmList> createState() => _AtmListState();
}

class _AtmListState extends State<AtmList> {
  // List<Map<String, String>> atms = [
  //   {
  //     'name': "Axis Bank ATM",
  //     'location':
  //         "Ground and 1st Floor, opposite Hotel Karpagam, Garacharama, Port Blair, Andaman and Nicobar Islands 744105",
  //     'open': "24 hours",
  //     'latitude': "11.622278",
  //     'longitude': "92.716778"
  //   },
  //   {
  //     'name': "SBI ATM",
  //     'location':
  //         "JPC8+CP4, Bhathu Basti, Port Blair, Andaman and Nicobar Islands 744105",
  //     'open': "24 hours",
  //     'latitude': "11.621000",
  //     'longitude': "92.716833",
  //   },
  //   {
  //     'name': "SBI ATM",
  //     'location':
  //         "JP73+77V, Garacharama, Port Blair, Andaman and Nicobar Islands 744103",
  //     'open': "24 hours",
  //     'latitude': "11.613250",
  //     'longitude': "92.703167",
  //   },
  //   {
  //     'name': "CANARA BANK ATM1 (formerly Syndicate Bank)",
  //     'location':
  //         "A AND N ADMINISTRATION COMPLEX,SECRETARIAT, Port Blair, Andaman and Nicobar Islands 744101",
  //     'open': "24 hours",
  //     'latitude': "11.662722",
  //     'longitude': "92.738000",
  //   },
  //   {
  //     'name': "Axis Bank ATM",
  //     'location':
  //         "Jayalaxmi Store, Doodhline, Nayagaon, Port Blair, Andaman and Nicobar Islands 744103",
  //     'open': "24 hours",
  //     'latitude': "11.646389",
  //     'longitude': "92.735528",
  //   },
  //   {
  //     'name': "ICICI Bank Atm",
  //     'location':
  //         "SPCNF341, ICICI BANK ATM INS Jarawa -Defense Headquarters Navy, Port Blair",
  //     'open': "24 hours",
  //     'latitude': "11.623389",
  //     'longitude': "92.726472",
  //   },
  //   {
  //     'name': "HDFC Bank ATM",
  //     'location':
  //         "Survey No 390/1/2, Circle No 1 Bathurst Basti, South Andaman, Andaman and Nicobar Islands 744103",
  //     'open': "24 hours",
  //     'latitude': "11.548194",
  //     'longitude': "92.675056",
  //   },
  //   {
  //     'name': "CANARA BANK ATM",
  //     'location':
  //         "SURVEY NO 92/1/2 POLYTECHNIC ROAD DOLLYGUNJ JUNCTION PS-PAHARGAONDOLLYGUNJ, Port Blair, Andaman and Nicobar Islands 744103",
  //     'open': "24 hours",
  //     'latitude': "11.634139",
  //     'longitude': "92.721278",
  //   },
  //   {
  //     'name': "SBI ATM",
  //     'location':
  //         "JPWR+269, Nayagaon, Port Blair, Andaman and Nicobar Islands 744112",
  //     'open': "24 hours",
  //     'latitude': "11.645056",
  //     'longitude': "92.740611",
  //   },
  //   {
  //     'name': "State Bank Of India ATM",
  //     'location':
  //         "Shadipur Junction, Shadipur, Port Blair, Andaman and Nicobar Islands 744106",
  //     'open': "24 hours",
  //     'latitude': "11.658333",
  //     'longitude': "92.746250",
  //   },
  //   {
  //     'name': "State Bank of India ATM",
  //     'location':
  //         "Near SBI Branch,Junglighat 744103, Junglighat, Port Blair, Andaman and Nicobar Islands 744101",
  //     'open': "24 hours",
  //     'latitude': "11.658278",
  //     'longitude': "92.731556",
  //   },
  //   {
  //     'name': "HDFC Bank ATM",
  //     'location':
  //         "201, MA Rd, Junglighat, Port Blair, Andaman and Nicobar Islands 744103",
  //     'open': "24 hours",
  //     'latitude': "11.659611",
  //     'longitude': "92.731528",
  //   },
  //   {
  //     'name': "Axis Bank ATM",
  //     'location':
  //         "Municipal Office, Ground Floor Aberdeen Market, opp. Port Blair, Port Blair, Andaman and Nicobar Islands 744101",
  //     'open': "24 hours",
  //     'latitude': "11.631083",
  //     'longitude': "92.727750",
  //   },
  //   {
  //     'name': "ICICI Bank Atm",
  //     'location':
  //         "S1CNS562,Icici Bank Atm Mb23, Middlepoint, Port Blair, Andaman and Nicobar Islands 744101",
  //     'open': "24 hours",
  //     'latitude': "11.645528",
  //     'longitude': "92.735694",
  //   },
  //   {
  //     'name': "A&N State Cooperative Bank ATM",
  //     'location':
  //         "State Co-Op Bank LTD, 98, Maulana Azad Road, Nayagaon, Port Blair, Andaman and Nicobar Islands 744101",
  //     'open': "24 hours",
  //     'latitude': "11.632944",
  //     'longitude': "92.717000",
  //   },
  //   {
  //     'name': "Axis Bank ATM",
  //     'location':
  //         "State Co-Op Bank LTD, 98, Maulana Azad Road, Nayagaon, Port Blair, Andaman and Nicobar Islands 744101",
  //     'open': "24 hours",
  //     'latitude': "11.632944",
  //     'longitude': "92.727750",
  //   },
  // ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = setHeight(context, factor: 1);
    double width = setWidth(context, factor: 1);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: setColors.body),
        elevation: 0.0,
        backgroundColor: setColors.appBar,
        title: const Text(
          "Atm",
          style: TextStyle(color: setColors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection("atms").snapshots(),
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
                List<Map<String, dynamic>> atms = [];
                snapshot.data!.docs.forEach((element) {
                  atms.add(element.data());
                });
                atms = Sort.bubbleSort(atms);
                return Container(
                  padding: EdgeInsets.only(
                      right: width * 0.03,
                      left: width * 0.03,
                      top: height * 0.02),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: atms.length,
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
                          onTap: () async {
                            double latitude, longitude;
                            latitude = double.parse(atms[index]['latitude']!);
                            longitude = double.parse(atms[index]['longitude']!);
                            MapUtils.openMap(latitude, longitude);
                            MapsLauncher.launchCoordinates(latitude, longitude);
                          },
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
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(""),
                              Row(
                                children: [
                                  Container(
                                    width: width * 0.7,
                                    child: Text(
                                      atms[index]['name']!,
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
                                      atms[index]['location']!,
                                      maxLines: 3,
                                      style:  TextStyle(
                                        fontSize: 13,
                                        color: setColors.white.withOpacity(0.6),
                                      ),
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
                                                        double.parse(atms[index]
                                                            ['latitude']!),
                                                        double.parse(atms[index]
                                                            ['longitude']!),
                                                        currPoss.latitude,
                                                        currPoss.longitude) /
                                                    1000) >=
                                                10
                                            ? (((Geolocator.distanceBetween(double.parse(atms[index]['latitude']!), double.parse(atms[index]['longitude']!), currPoss.latitude, currPoss.longitude) + 4) /
                                                        1000)
                                                    .toStringAsFixed(3)
                                                    .toString() +
                                                " kms")
                                            : (((Geolocator.distanceBetween(
                                                                double.parse(atms[index]['latitude']!),
                                                                double.parse(atms[index]['longitude']!),
                                                                currPoss.latitude,
                                                                currPoss.longitude) +
                                                            1) /
                                                        1000)
                                                    .toStringAsFixed(3)
                                                    .toString() +
                                                " kms"),
                                        style:  TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,color: setColors.white.withOpacity(0.6),
                                        )),
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
