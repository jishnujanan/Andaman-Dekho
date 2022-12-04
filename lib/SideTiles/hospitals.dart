import 'package:app/SideTiles/sort.dart';
import 'package:app/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../helpers.dart';

class Hospitals extends StatefulWidget {
  const Hospitals({Key? key}) : super(key: key);

  @override
  State<Hospitals> createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
  // List<Map<String, String>> hospitals = [
  //   {
  //     "name": "Pillar Hospital",
  //     "location":
  //         "VIP Rd, Lamba Line, Port Blair, Andaman and Nicobar Islands 744103",
  //     "phone": "03192 233193, 03192 233993",
  //     "hours": "Monday to Sunday from 12:00 am to 11: 59 pm",
  //     "latitude": "11.653260236607343",
  //     "longitude": "92.73060451732331"
  //   },
  //   {
  //     "name": "GB Pant Hospital",
  //     "location":
  //         "near Cellular Jail,Atlanta Point, Port Blair, Andaman and Nicobar Islands 744104",
  //     "phone": "03192 243 653",
  //     "hours": "Open 24 hours",
  //     "latitude": "11.675461158843085",
  //     "longitude": "92.74738187807138"
  //   },
  //   {
  //     "name": "AYUSH hospital",
  //     "location":
  //         "Ayush Hospital Rd, Junglighat, Port Blair, Andaman and Nicobar Islands 744103",
  //     "phone": "0",
  //     "hours": "9.00 am to 1.30 pm and 3pm to 4pm",
  //     "latitude": "11.66212959783816",
  //     "longitude": "92.7291340509387"
  //   },
  //   {
  //     "name": "Apollo health centre",
  //     "location":
  //         "Thomas Colony, Junglighat, Port Blair, Andaman and Nicobar Islands 744101",
  //     "phone": "0",
  //     "hours": "Monday to Sunday from 12:00 am to 11: 59 pm",
  //     "latitude": "11.659818235726332",
  //     "longitude": "92.73572525110865"
  //   },
  //   {
  //     "name": "Rohin's Eye and Multispeciality Hospital",
  //     "location":
  //         "23 AIR Road, Delanipur, Port Blair, Andaman and Nicobar Islands 744102",
  //     "phone": "+91 3192 244933",
  //     "hours": "9:30 a.m. to 6:30 p.m.",
  //     "latitude": "11.66763271964201",
  //     "longitude": "92.72587367065235"
  //   },
  //   {
  //     "name": "SANJEEVANI HOSPITAL",
  //     "location":
  //         "Anarkali , Near Delanipur Go straight from road opposite Mansha Regency and take the first left Port Blair, Andaman and Nicobar Islands 744102",
  //     "phone": "099332 69116",
  //     "hours": "8:30 a.m. to 1:00 p.m. and 5:00 p.m. to 8:00 p.m.",
  //     "latitude": "11.674175270615875",
  //     "longitude": "92.72576369095285"
  //   },
  //   {
  //     "name": "PRIMARY HEALTH CENTRE D/FARM",
  //     "location":
  //         "MP3G+MHH, Dairy Farm, Port Blair, Andaman and Nicobar Islands 744103",
  //     "phone": "0",
  //     "hours": "8:30 AM to 1PM and 2PM to 4:30PM",
  //     "latitude": "11.654153595516128",
  //     "longitude": "92.72645896008929"
  //   },
  //   {
  //     "name": "Dr.Agarwals Eye Hospital, Port Blair,",
  //     "location":
  //         "32/4, RGT Rd, near Radha Govindh Temle, Shadipur, Port Blair, Andaman and Nicobar Islands 744106",
  //     "phone": "075062 69799",
  //     "hours": "8:30 AM to 7:00 PM, Closed on Sunday",
  //     "latitude": "11.663964273002465",
  //     "longitude": "92.7465344295876"
  //   },
  //   {
  //     "name": "Maricar Hospital",
  //     "location":
  //         "near masjid, 3 vijay baugh road, Junglighat, Port Blair, Andaman and Nicobar Islands 744103",
  //     "phone": "03192 233 434",
  //     "hours": "9 a.m. to 7:30 p.m. closed on Sunday",
  //     "latitude": "11.656255766572444",
  //     "longitude": "92.73203785875432"
  //   },
  //   {
  //     "name": "Keraleeya Ayurveda Samajam Hospital & Research Center",
  //     "location":
  //         "Near Tamil Sangam, Pongy Kyaung Road, Port Blair HO, Port Blair, 744 101",
  //     "phone": "03192 244445",
  //     "hours": "Open 24 hrs",
  //     "latitude": "11.668728417478139",
  //     "longitude": "92.7334516566684"
  //   },
  //   {
  //     "name": "Dr Rekha’s Ayurvedic Hospital",
  //     "location":
  //         "RGT Rd, Port Blair, Andaman and Nicobar Islands 744 101, India",
  //     "phone": "+91 96 79 510588",
  //     "hours": "7 a.m. to 7 p.m.",
  //     "latitude": "11.663885664511158",
  //     "longitude": "92.74704636876824"
  //   },
  //   {
  //     "name": "Garacharma Hospital",
  //     "location": "Port Blair, Andaman and Nicobar Islands, India",
  //     "phone": "0",
  //     "hours": "Open 24 hrs",
  //     "latitude": "11.615902797129412",
  //     "longitude": "92.70585161508508"
  //   },
  //   {
  //     "name": "Dinesh dental Specialty Centre",
  //     "location":
  //         "Goal Ghar, Thomas Colony, Junglighat, Port Blair, Andaman and Nicobar Islands 744101",
  //     "phone": "03192 231 656",
  //     "hours": "9am–12pm, 4–7pm, closed on Sunday.",
  //     "latitude": "11.661751540675889",
  //     "longitude": "92.73480162007272"
  //   },
  //   {
  //     "name": "Thyrocare and CSB Clinic",
  //     "location":
  //         "MP9P+PC4, Phoenix Bay, Port Blair, Andaman and Nicobar Islands 744101",
  //     "phone": "03192 245 291",
  //     "hours": "7 a.m. to 8 p.m",
  //     "latitude": "11.669248245704429",
  //     "longitude": "92.73606700547519"
  //   },
  //   {
  //     "name": "INHS Dhanvantari",
  //     "location": "Goalghar, Port Blair Ho, Port Blair, 744 101",
  //     "phone": "03192 230383, 9434280622",
  //     "hours":
  //         "Monday to Saturday 09:00 am to 01:00 pm and 04:00 pm to 08:00 pm",
  //     "latitude": "11.665374552602016",
  //     "longitude": "92.7319069323517"
  //   },
  //   {
  //     "name": "Amritha Health Care",
  //     "location":
  //         "near Rajasthan Mandir, AHW Colony, Shadipur, Port Blair, Andaman and Nicobar Islands 744106",
  //     "phone": "03192 231344, 220187",
  //     "hours": "Monday to Saturday from 09:00 am to 05:00 pm",
  //     "latitude": "11.66289123448032",
  //     "longitude": "92.73236616444674"
  //   },
  //   {
  //     "name": "Regional Medical Research Centre (ICMR)",
  //     "location":
  //         "Post Bag 13, Dollygunj, Port Blair, Andaman and Nicobar Islands 744103",
  //     "phone": "03192 251158/59",
  //     "hours": "9 a.m. to 5:30 p.m. closed on Sunday.",
  //     "latitude": "11.63469033358292",
  //     "longitude": "92.71463364585308"
  //   },
  //   {
  //     "name": "Sub Centre Havelock",
  //     "location":
  //         "Sub Centre Krishna Nagar, Sub Centre Kalapathar, Andaman and Nicobar Islands 744211",
  //     "phone": "0",
  //     "hours": "0",
  //     "latitude": "12.0084523396279",
  //     "longitude": "92.96984369302395"
  //   },
  //   {
  //     "name": "Primary Health Centre Havelock ",
  //     "location": "SH4,Govind Nagar, Andaman and Nicobar Islands 744211",
  //     "phone": "0",
  //     "hours": "0",
  //     "latitude": "12.03085073105779",
  //     "longitude": "92.99441893689338"
  //   },
  //   {
  //     "name": "Primary Health Centre Neil Sub Centre Neil, Sitapur",
  //     "location": "SH6, Neil Kendra, Andaman and Nicobar Islands 744104",
  //     "phone": "0",
  //     "hours": "Open 24 hours",
  //     "latitude": "11.819226789874277",
  //     "longitude": "93.04200027995192"
  //   },
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // hospitals.sort((a, b) {
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
        elevation: 0.0,
        backgroundColor: setColors.appBar,
        title: const Text(
          "Hospitals",
          style: TextStyle(color: setColors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("hospitals")
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
                List<Map<String,dynamic>> hospitals=[];
                snapshot.data!.docs.forEach((element) {
                  hospitals.add(element.data());
                });

                return Container(
                  padding: EdgeInsets.only(
                      right: width * 0.03, left: width * 0.03, top: height * 0.02),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: hospitals.length,
                    itemBuilder: (context, index) {
                      hospitals=Sort.bubbleSort(hospitals);
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
                          contentPadding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.01),
                          onTap: () async {
                            double latitude, longitude;
                            latitude = double.parse(hospitals[index]['latitude']!);
                            longitude = double.parse(hospitals[index]['longitude']!);
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
                                  const Icon(LineIcons.hospital,color: setColors.white),
                                  SizedBox(
                                    width: width * 0.7,
                                    child: Text(
                                      "  "+hospitals[index]['name']!,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: setColors.white,
                                          fontWeight: FontWeight.bold, fontSize: 20),
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
                                      hospitals[index]['location']!,
                                      maxLines: 3,
                                      style:  TextStyle(fontSize: 13,color: setColors.white.withOpacity(1),),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(""),
                              hospitals[index]['phone'] != "0" ? Column(
                                children: [
                                  Row(
                                    children: [
                                       Text(
                                        "Phone     : ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: setColors.white.withOpacity(0.9),
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        width: width * 0.65,
                                        child: Text(
                                          hospitals[index]['phone']!,
                                          maxLines: 3,
                                          style: const TextStyle(fontSize: 13,color: setColors.white,),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ) : const SizedBox(height: 0,),
                              hospitals[index]['phone'] != "0" ? const Text("") : const SizedBox(height: 0,),
                              hospitals[index]['hours'] != "0" ? Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Text(
                                        "Hours      : ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: setColors.white.withOpacity(0.9),
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        width: width * 0.65,
                                        child: Text(
                                          hospitals[index]['hours']!,
                                          maxLines: 3,
                                          style:  const TextStyle(fontSize: 13,color: setColors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ) : const SizedBox(height: 0,),
                              hospitals[index]['hours'] != "0" ? const Text("") : const SizedBox(height: 0,),
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
                                        (Geolocator.distanceBetween(double.parse(hospitals[index]['latitude']!), double.parse(hospitals[index]['longitude']!), currPoss.latitude, currPoss.longitude) / 1000) >= 10
                                            ? (((Geolocator.distanceBetween(
                                            double.parse(
                                                hospitals[index]['latitude']!),
                                            double.parse(hospitals[index]
                                            ['longitude']!),
                                            currPoss.latitude,
                                            currPoss.longitude) + 4 )/
                                            1000)
                                            .toStringAsFixed(3)
                                            .toString() +
                                            " kms")
                                            : (((Geolocator.distanceBetween(
                                            double.parse(
                                                hospitals[index]['latitude']!),
                                            double.parse(
                                                hospitals[index]['longitude']!),
                                            currPoss.latitude,
                                            currPoss.longitude)+1)/
                                            1000)
                                            .toStringAsFixed(3)
                                            .toString() +
                                            " kms"),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 15,color: setColors.white,)),
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
