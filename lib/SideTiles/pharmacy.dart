import 'package:app/SideTiles/sort.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../helpers.dart';

class Pharmacy extends StatefulWidget {
  const Pharmacy({Key? key}) : super(key: key);

  @override
  State<Pharmacy> createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
  // List<Map<String, String>> pharmacy = [
  //   {
  //     "name": "Raja Medical Store",
  //     "location":
  //         "Aberdeen Bazar, Aberdeen, Port Blair, Andaman and Nicobar Islands 744101",
  //     "phone": "094742 33844",
  //     "hours": "10 a.m. to 7 p.m.",
  //     "latitude": "11.670506739632751",
  //     "longitude": "92.7432853855305"
  //   },
  //   {
  //     "name": "Apollo Pharmacy",
  //     "location":
  //         "Shop No 1, Junction, Delanipur, Port Blair, Andaman and Nicobar Islands 744102",
  //     "phone": "1860 500 0101",
  //     "hours": "7 a.m. to 11 p.m.",
  //     "latitude": "11.672595036775679",
  //     "longitude": "92.7294357510186"
  //   },
  //   {
  //     "name": "Tamil Nadu medical store",
  //     "location":
  //         "Dairy Farm, Junglighat, Port Blair, Andaman and Nicobar Islands 744103",
  //     "phone": "9434279738",
  //     "hours": "8 a.m. to 9 p.m.",
  //     "latitude": "11.656866283615289",
  //     "longitude": "92.73215300436539"
  //   },
  //   {
  //     "name": "Apollo Pharmacy",
  //     "location":
  //         "Shop No 7, Police Gurudwara Complex, Aberdeen Bazar, Port Blair, Andaman and Nicobar Islands 744101",
  //     "phone": "03192 235 594",
  //     "hours": "Closes 11PM",
  //     "latitude": "11.668643112646254",
  //     "longitude": "92.74282872785822"
  //   },
  //   {
  //     "name": "Shakshi Pharmaceuticals",
  //     "location":
  //         "MA Rd,Beside YES Bank, Thomas Colony, Junglighat, Port Blair, Andaman and Nicobar Islands 744101",
  //     "phone": "094342 80458",
  //     "hours": "9AM to 8PM",
  //     "latitude": "11.659855115595922",
  //     "longitude": "92.73190622724145"
  //   },
  //   {
  //     "name": "Medicine Corner",
  //     "location": "Junglighat, Port Blair, Andaman and Nicobar Islands 744103",
  //     "phone": "03192 231 962",
  //     "hours": "0",
  //     "latitude": "11.662980728582436",
  //     "longitude": "92.73237801168878"
  //   },
  //   {
  //     "name": "TSG Pharmaceuticals",
  //     "location":
  //         "Babu Ln, Aberdeen Bazar, Mohan Pura, Port Blair, Andaman and Nicobar Islands 744101",
  //     "phone": "095318 49999",
  //     "hours": "0",
  //     "latitude": "11.670300616300166",
  //     "longitude": "92.7407081458011"
  //   },
  //   {
  //     "name": "New Tamil Nadu Medicals , Port Blair",
  //     "location":
  //         "No S-9 , Meshack Market, Aberdeen Bazar, Port Blair, Andaman and Nicobar Islands744101",
  //     "phone": "+91 3192 231305, +91 9434279738.",
  //     "hours": "closes 8:30 p.m.",
  //     "latitude": "11.667754063281599",
  //     "longitude": "92.74126576833304"
  //   },
  //   {
  //     "name": "100 MG Pharmacy",
  //     "location":
  //         "Shop no. 5, Maulana Azad Road, below Indian bank, Port Blair, Andaman and Nicobar Islands 744101",
  //     "phone": "09933280044",
  //     "hours": "closes 9:30 p.m.",
  //     "latitude": "11.667910898830153",
  //     "longitude": "92.73776948182463"
  //   },
  //   {
  //     "name": "Annvesha Pharmacy",
  //     "location":
  //         "junction, Airport Authority Colony, Delanipur, Port Blair, Andaman and Nicobar Islands 744102",
  //     "phone": "+91 94342 87858",
  //     "hours": "closes 9:00 p.m.",
  //     "latitude": "11.669356933456983",
  //     "longitude": "92.72777574134979"
  //   },
  //   {
  //     "name": "YUVARAJ PHARMACY",
  //     "location":
  //         "Unnamed Road, Buniyadabad, Haddo, Port Blair, Andaman and Nicobar Islands 744102",
  //     "phone": "0",
  //     "hours": "9AM to 7AM",
  //     "latitude": "11.67154998768747",
  //     "longitude": "92.72167140119505"
  //   },
  //   {
  //     "name": "Devraj Medical Store",
  //     "location":
  //         "MPCV+8M9, Supply Lane, Aberdeen Bazar, Atlanta Point, Port Blair, Andaman and Nicobar Islands 744104",
  //     "phone": "+91 3192 234344",
  //     "hours": "9AM to 9PM",
  //     "latitude": "11.671043453260951",
  //     "longitude": "92.74428501251374"
  //   },
  //   {
  //     "name": "Murugan Pharmacy",
  //     "location":
  //         "No. 4, Sardar Bhagvan Singh Complex, Dollygunj, Port Blair, Andaman and Nicobar Islands 744103",
  //     "phone": "099332 62519",
  //     "hours": "Closes - 8:30PM ⋅ Opens - 9AM",
  //     "latitude": "11.634210272071053",
  //     "longitude": "92.72226490999027"
  //   },
  //   {
  //     "name": "M/s Jaya Medical Store",
  //     "location":
  //         "MPGF+QF6, Haddo, Port Blair, Andaman and Nicobar Islands 744102",
  //     "phone": "+91 3192 242814",
  //     "hours": "8:30AM – 8:00PM , closed on Sunday.",
  //     "latitude": "11.677146247938573",
  //     "longitude": "92.72367415484152"
  //   },
  //   {
  //     "name": "Sandhya Pharmacy",
  //     "location":
  //         "no.01,calicut junction, near govt sec school, Port Blair, Andaman and Nicobar Islands 744105",
  //     "phone": "096795 11948",
  //     "hours": "8:00AM to 9:30PM",
  //     "latitude": "11.599116900567742",
  //     "longitude": "92.71686729793802"
  //   },
  //   {
  //     "name": "HEALTH4U MULTISPECIALITY CLINIC AND PHARMACY",
  //     "location":
  //         "C/O DR MANMOHAN ROY, near MITALI ENTERPRISES, Thomas Colony, Junglighat, Port Blair, Andaman and Nicobar Islands 744103, Thomas Colony,",
  //     "phone": "089009 14124",
  //     "hours": "8AM to 8PM",
  //     "latitude": "11.661622913175304",
  //     "longitude": "92.73283409716903"
  //   },
  //   {
  //     "name": "Chennai Medicals",
  //     "location": "Mohanpura, Port Blair, Andaman and Nicobar Islands 744104",
  //     "phone": "0",
  //     "hours": "9AM to 9PM",
  //     "latitude": "11.61618410216134",
  //     "longitude": "92.70619213843818"
  //   },
  //   {
  //     "name": "Happy Medicare Portblair",
  //     "location":
  //         "ATR Main Road, opp. PHC, Garacharama, Port Blair, Andaman and Nicobar Islands 744105",
  //     "phone": "099332 45933",
  //     "hours": "9:00AM to 9:30PM",
  //     "latitude": "11.650299139077667",
  //     "longitude": "92.73288899056733"
  //   },
  //   {
  //     "name": "Medical Store in Havelock",
  //     "location": "Govind Nagar, Andaman and Nicobar Islands 744211",
  //     "phone": "0",
  //     "hours": "Opens 8AM",
  //     "latitude": "12.03022959488926",
  //     "longitude": "92.99534821822152"
  //   },
  //   {
  //     "name": "Gaurav medical",
  //     "location": "radhanagar, Andaman and Nicobar Islands 744211",
  //     "phone": "0",
  //     "hours": "Open 24 hours",
  //     "latitude": "11.984749051064739",
  //     "longitude": "92.95071665134967"
  //   },
  //   {
  //     "name": "Farmacia",
  //     "location": "SH6, Neil Kendra, Andaman and Nicobar Islands 744104",
  //     "phone": "0",
  //     "hours": "0",
  //     "latitude": "11.834878552377646",
  //     "longitude": "92.03035558141272"
  //   },
  // ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // pharmacy.sort((a, b) {
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
          "Pharmacy",
          style: TextStyle(color: setColors.white,),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("pharmacy")
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
              if(snapshot.data!.docs.isNotEmpty)
                {
                  List<Map<String,dynamic>> pharmacy=[];
                  snapshot.data!.docs.forEach((element) {
                    pharmacy.add(element.data());
                  });
                  pharmacy=Sort.bubbleSort(pharmacy);
                  return Container(
                    padding: EdgeInsets.only(
                        right: width * 0.03,
                        left: width * 0.03,
                        top: height * 0.02),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: pharmacy.length,
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
                                horizontal: width * 0.04, vertical: height * 0.01),
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
                              latitude = double.parse(pharmacy[index]['latitude']!);
                              longitude =
                                  double.parse(pharmacy[index]['longitude']!);
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
                                    const Icon(LineIcons.medicalBriefcase,color: setColors.white),
                                    SizedBox(
                                      width: width * 0.7,
                                      child: Text(
                                        "  " + pharmacy[index]['name']!,
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
                                        pharmacy[index]['location']!,
                                        maxLines: 3,
                                        style:  TextStyle(fontSize: 13,color: setColors.white.withOpacity(0.9)),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(""),
                                pharmacy[index]['phone'] != "0"
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
                                            pharmacy[index]['phone']!,
                                            maxLines: 3,
                                            style:
                                             TextStyle(fontSize: 14,color: setColors.white.withOpacity(0.9),),
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
                                pharmacy[index]['phone'] != "0"
                                    ? const Text("")
                                    : const SizedBox(height: 0),
                                pharmacy[index]['hours'] != "0"
                                    ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Hours      : ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: setColors.white,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          width: width * 0.65,
                                          child: Text(
                                            pharmacy[index]['hours']!,
                                            maxLines: 3,
                                            style:
                                            TextStyle(fontSize: 14,color: setColors.white.withOpacity(0.9),),
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
                                pharmacy[index]['hours'] != "0"
                                    ? const Text("")
                                    : const SizedBox(height: 0),
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
                                              double.parse(pharmacy[index]
                                              ['latitude']!),
                                              double.parse(pharmacy[index]
                                              ['longitude']!),
                                              currPoss.latitude,
                                              currPoss.longitude) /
                                              1000) >=
                                              10
                                              ? (((Geolocator.distanceBetween(double.parse(pharmacy[index]['latitude']!), double.parse(pharmacy[index]['longitude']!), currPoss.latitude, currPoss.longitude) + 4) /
                                              1000)
                                              .toStringAsFixed(3)
                                              .toString() +
                                              " kms")
                                              : (((Geolocator.distanceBetween(
                                              double.parse(pharmacy[index]['latitude']!),
                                              double.parse(pharmacy[index]['longitude']!),
                                              currPoss.latitude,
                                              currPoss.longitude) +
                                              1) /
                                              1000)
                                              .toStringAsFixed(3)
                                              .toString() +
                                              " kms"),
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: setColors.white.withOpacity(0.9),)),
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
                }
              else
                {
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
