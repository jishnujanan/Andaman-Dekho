import 'package:app/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:app/SideTiles/sort.dart';
import '../helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Banks extends StatefulWidget {
  const Banks({Key? key}) : super(key: key);

  @override
  State<Banks> createState() => _BanksState();
}

class _BanksState extends State<Banks> {
  List<Map<String, String>> banks = [
    {
      'name': "State Bank of India",
      'location':
          "Bhathu Basti, Port Blair, Andaman and Nicobar Islands 744104",
      "hours": "10AM to 4PM, closed on Sunday",
      "phone": "03192 252 078",
      'latitude': "11.621052319505027",
      'longitude': "92.71697084341349",
    },
    {
      'name': "HDFC Bank",
      'location':
          "Survey No 390/1/2, Upper Ground Floor Garacharma, Bhathu Basti, Andaman and Nicobar Islands 744103",
      "hours": "9:30AM to 3:30PM, closed on Saturday and Sunday",
      "phone": "075739 19585, 022 6846 1208",
      'latitude': "11.622998135889416",
      'longitude': "92.71079374665744",
    },
    {
      'name': "Syndicate Bank Port blair Directorate of Health Services Branch",
      'location':
          "D.H.S. Building G.B. Panth Road, Port Blair, Andaman and Nicobar Islands 744104",
      "hours": "0",
      "phone": "094342 88271",
      'latitude': "11.621686687311865",
      'longitude': "92.7224168971687",
    },
    {
      'name': "Bank of India",
      'location':
          "Church Lane Phoenix Bay Near Carmel School Phoenix Bay, Port Blair, SOUTH ANDAMAN, Andaman and Nicobar Islands 744101",
      "hours": "10:00 AM - 04:00 PM",
      "phone": "03192-2234400",
      'latitude': "11.632659767501679",
      'longitude': "92.71931232536323",
    },
    {
      'name': "ICICI Bank Port Blair-Branch & ATM",
      'location':
          "MB 23, Middle Point, Port Blair, Andaman and Nicobar Islands 744101",
      "hours": "9:30AM to 3:00PM, closed on Sunday",
      "phone": "1800 102 4242",
      'latitude': "11.663647137784904",
      'longitude': "92.73309626833294",
    },
    {
      'name': "IDBI Bank Port Blair Branch & ATM",
      'location':
          " FIRST FLOOR, ABOVE KARTAR CLOTH STORE, 26 MG ROAD, RGT Rd, Aberdeen Bazar, Aberdeen, Port Blair, Andaman and Nicobar Islands 744101",
      "hours": "Open 24 hrs",
      "phone": "03192 243 044",
      'latitude': "11.670401639716408",
      'longitude': "92.74342949716915",
    },
    {
      'name': "State Bank of India",
      'location':
          "Bhathu Basti, Port Blair, Andaman and Nicobar Islands 744104",
      "hours": "10AM to 4PM, closed on Sunday",
      "phone": "03192 252 078",
      'latitude': "11.621052319505027",
      'longitude': "92.71697084341349",
    },
    {
      'name': "YES Bank",
      'location':
          "Survey No 104/1/2, GF & 1st Flr, Junglighat, Andaman and Nicobar Islands 744103",
      "hours": "9:30AM to 3:30 PM",
      "phone": "1800 1200",
      'latitude': "11.660048662842886",
      'longitude': "92.7318929971691",
    },
    {
      'name': "Andaman And Nicobar State Co-operative Bank",
      'location':
          "JPC8+6FG, Bhathu Basti, Port Blair, Andaman and Nicobar Islands 744103",
      "hours": "9:00 AM - 3:30 PM, closed on Sunday",
      "phone": "1800-345-3196",
      'latitude': "11.620812505891541",
      'longitude': "92.71623431251321",
    },
    {
      'name': "HDFC Bank",
      'location':
          "201, MA Rd, Thomas Colony, Junglighat, Port Blair, Andaman and Nicobar Islands 744103",
      "hours": "9:30AM to 3:30AM, closed on Sunday",
      "phone": "075739 19585, 022 6846 1208",
      'latitude': "11.660905083258974",
      'longitude': "92.73184568304414",
    },
    {
      'name': "Axis Bank",
      'location':
          "Ground & 1st Floor, opposite Hotel Karpagam, Garacharama, Port Blair, Andaman and Nicobar Islands 744105",
      "hours": "9:30AM to 3:30AM, closed on Sunday",
      "phone": "1860 500 5555",
      'latitude': "11.607700480991308",
      'longitude': "92.7053280001212",
    },
    {
      'name': "Vijaya Bank",
      'location':
          "MPCV+4C3, Rajiv Gandhi Nagar, Port Blair, Andaman and Nicobar Islands 744101",
      "hours": "0",
      "phone": "0",
      'latitude': "11.670603385471464",
      'longitude': "92.74348976364364",
    },
    {
      'name': "Canara Bank",
      'location':
          "JP73+56X, Garacharama, Port Blair, Andaman and Nicobar Islands 744103",
      "hours": "10AM to 4PM, closed on Saturday and Sunday",
      "phone": "24312280",
      'latitude': "11.613403823484866",
      'longitude': "92.70307028471603",
    },
    {
      'name': "Indian Overseas Bank",
      'location':
          "60, MA Rd, Phoenix Bay, Port Blair, Andaman and Nicobar Islands 744101",
      "hours": "0",
      "phone": "095853 47833",
      'latitude': "11.668383912913738",
      'longitude': "92.73822730638422",
    },
    {
      'name': "Canara Bank",
      'location':
          "MPCV+265, Aberdeen Bazar, Rajiv Gandhi Nagar, Port Blair, Andaman and Nicobar Islands 744101",
      "hours": "9am–1pm, 1:30–2:30pm, closed on Sunday",
      "phone": "0",
      'latitude': "11.671428632062545",
      'longitude': "92.74295597736071",
    },
    {
      'name': "Allahabad Bank in Port Blair",
      'location':
          "Post Box No. 304, Port Blair, Andaman and Nicobar Islands, 744101",
      "hours":
          "Monday to Friday: 10 AM to 4 PM, Saturday - 10 AM to 4 PM(Except 2nd and 4th Saturday)",
      "phone": "03192 230267",
      'latitude': "11.621820169424877",
      'longitude': "92.72226145484095",
    },
    {
      'name': "Axis Bank in Port Blair",
      'location':
          "5 Middle Point, Andaman Dt, Andaman and Nicobar Islands, 744101",
      "hours": "9:30am to 3:30pm, closed on Sunday",
      "phone": "03192 244108, 1860 500 5555",
      'latitude': "11.667097685414314",
      'longitude': "92.73338453949688",
    },
    {
      'name': "Canara Bank in Port Blair",
      'location':
          "Krishna House, Aberdeen Bazaar, Port Blair, Andaman and Nicobar Islands, 744101",
      "hours": "9am–1pm, 1:30–2:30pm. Closed on Sunday.",
      "phone": "03192 233085",
      'latitude': "11.670034164756974",
      'longitude': "92.74310461505151",
    },
    {
      'name': "Bank of Baroda in Port Blair",
      'location':
          "BJP Bhavan 1st Floor, Supply Line, M. G Road (Middle Point), Port Blair, Andaman and Nicobar Islands, 744101",
      "hours": "10am to 5pm, closed on Saturday and Sunday",
      "phone": "03192 244462",
      'latitude': "11.668775402210022",
      'longitude': "92.73314814459549",
    },
    {
      'name': "Indian Overseas Bank in Port Blair",
      'location':
          "Delanipur Junction, Po Haddo Port Blair, Andaman and Nicobar Islands, 744102",
      "hours": "Open 24hrs",
      "phone": "+913192230289,03192 230392, 230289",
      'latitude': "11.667076835185506",
      'longitude': "92.73849886648007",
    },
    {
      'name': "United Bank of India(Branch Jungly Ghat (Port Blair))",
      'location':
          "10 Gandhi Bhavan, MG Road, Aberdeen Bazaar, Andaman and Nicobar Islands, 744101",
      "hours": "0",
      "phone": "0",
      'latitude': "11.66737320659043",
      'longitude': "92.73788185100983",
    },
    {
      'name': "Vijaya Bank in Port Blair",
      'location':
          "P B No7, Aberdeen bazaar, Port Blair, Andaman and Nicobar Islands, 744101",
      "hours": "0",
      "phone": "0",
      'latitude': "11.667568792086726",
      'longitude': "92.74123136785028",
    },
    {
      'name': "Punjab National Bank in Port Blair",
      'location':
          "Plot No. 105, Junglighat, Port Blair, Andaman and Nicobar Islands, 744103",
      "hours": "0",
      "phone": "03192 232848",
      'latitude': "11.676545264855541",
      'longitude': "92.73134013835589",
    },
    {
      'name': "Syndicate Bank in Port Blair(Branch: Port Blair)",
      'location':
          "19- Tagore Road, Gandhi Nagar, Mohanpura, Port Blair, Andaman and Nicobar Islands, 744101",
      "hours": "0",
      "phone": "03192 232568",
      'latitude': "11.66993023239218",
      'longitude': "92.73762992034078",
    },
    {
      'name': "Syndicate Bank in Port Blair(Branch: Port Blair MES Hadoo)",
      'location': "NSRY Complex, Haddo, Port Blair, 744102",
      "hours": "0",
      "phone": "03192 232373,03192 240842",
      'latitude': "11.61983315993983",
      'longitude': "92.7243135542587",
    },
    {
      'name': "Syndicate Bank in Port Blair(Branch: Port Blair Secretariat)",
      'location': " Secretariat building, Secretariat PO, Port Blair,744101",
      "hours": "10AM to 4PM, closed on Sunday",
      "phone": "03192 240842",
      'latitude': "11.663261754608616",
      'longitude': "92.73894187919865",
    },
    {
      'name':
          "Syndicate Bank in Port Blair(Branch: Port Blair Municipal Council)",
      'location':
          "Municipal Building, Port Blair, Andaman and Nicobar Islands, 744101",
      "hours": "10AM to 4PM, closed on Sunday",
      "phone": "03192 241877",
      'latitude': "11.663261754608616",
      'longitude': "92.73894187919865",
    },
    {
      'name':
          "Syndicate Bank in Port Blair(Branch: Port Blair DIR of Health Services)",
      'location':
          "Directorate of Health Services, Building, G B Panth Road, Port Blair, 744104",
      "hours": "0",
      "phone": "03192 240106",
      'latitude': "11.673635147056212",
      'longitude': "92.7471356304375",
    },
    {
      'name': "State Bank of India(Branch: Port Blair)",
      'location': "Port Blair,  Andaman and Nicobar Islands",
      "hours":
          "Monday to Friday: 10 AM to 4 PM, Saturday - 10 AM to 4 PM(Except 2nd and 4th Saturday",
      "phone": "03192 236638, 230224, 240717, 232457, 233539, 245671, 24423",
      'latitude': "11.65880834500083",
      'longitude': "92.73146770875329",
    },
    {
      'name': "State Bank of India(Branch: Brichgunj)",
      'location':
          "P.O Junglighat, Port Blair, Dist. Andaman, Andaman and Nicobar, 744103",
      "hours": "10:00am to 4:00PM, closed on Sunday",
      "phone": "03192 286833, 286253",
      'latitude': "11.610675377204968",
      'longitude': "92.74455149155446",
    },
    {
      'name': "State Bank of India(Branch: Garacharma)",
      'location': "Dist. Andaman, Andaman and Nicobar Islands, 744101",
      "hours": "10:00am to 4:00PM, closed on Sunday",
      "phone": "03192 231823",
      'latitude': "11.621050495355865",
      'longitude': "92.71696997803238",
    },
    {
      'name': "State Bank of India",
      'location':
          "Dist. Havelock Lighthouse, Govind Nagar, Andaman and Nicobar Islands 744211",
      "hours": "10am to 4pm, closed on sunday",
      "phone": "03192 282 287",
      'latitude': "12.036746931119149",
      'longitude': "92.99335972454939",
    },
    {
      'name': "HDFC BANK",
      'location':
          "Ground Floor Havelock Islands, Govind Nagar 3, Andaman and Nicobar Islands 744211",
      "hours": "9:30AM to 3:30PM, closed on Sunday",
      "phone": "022 6846 1208",
      'latitude': "12.02841371083967",
      'longitude': "93.00166322600904",
    },
    {
      'name': "CANARA BANK (formerly Syndicate Bank)",
      'location':
          "I FLOOR NEIL KENDRA NO.3 NEIL ISLAND, Port Blair, Andaman and Nicobar Islands 744101",
      "hours": "0",
      "phone": "1800 425 0018",
      'latitude': "11.832002012857842",
      'longitude': "93.02880853949864",
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // banks.sort((a, b) {
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
            "Banks",
            style: TextStyle(color: setColors.white),
          ),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection("banks").snapshots(),
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
                  List<Map<String, dynamic>> banks = [];
                  snapshot.data!.docs.forEach((element) {
                    banks.add(element.data());
                  });
                  banks = Sort.bubbleSort(banks);
                  return Container(
                    padding: EdgeInsets.only(
                        right: width * 0.03,
                        left: width * 0.03,
                        top: height * 0.02),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: banks.length,
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
                              latitude =
                                  double.parse(banks[index]['latitude']!);
                              longitude =
                                  double.parse(banks[index]['longitude']!);
                              MapUtils.openMap(latitude, longitude);
                              MapsLauncher.launchCoordinates(
                                  latitude, longitude);
                            },
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(""),
                                SizedBox(
                                  width: width * 0.7,
                                  child: SizedBox(
                                    width: width * 0.62,
                                    child: Text(
                                      banks[index]['name']!,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: setColors.white,
                                          fontSize: 20),
                                    ),
                                  ),
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
                                      width: width * 0.5,
                                      child: Text(
                                        banks[index]['location']!,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              setColors.white.withOpacity(0.9),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                snapshot.data!.docs[index]['hours'].toString().length>=3
                                    ? Column(
                                      children: [
                                        const Text(""),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                width: width * 0.5,
                                                child: Text(
                                                  banks[index]['hours'],
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: setColors.white
                                                        .withOpacity(0.9),
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const Text(""),
                                            ],
                                          ),
                                      ],
                                    )
                                    : const SizedBox(height: 0),
                                snapshot.data!.docs[index]['phone'] != "0"
                                    ? Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Phone      : ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: setColors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                width: width * 0.5,
                                                child: Text(
                                                  banks[index]['phone']!,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: setColors.white
                                                        .withOpacity(0.9),
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : const SizedBox(height: 0),
                                banks[index]['phone'] != "0"
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
                                      width: width * 0.5,
                                      child: Text(
                                          (Geolocator.distanceBetween(
                                                          double.parse(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['latitude']!),
                                                          double.parse(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['longitude']!),
                                                          currPoss.latitude,
                                                          currPoss.longitude) /
                                                      1000) >=
                                                  10
                                              ? (((Geolocator.distanceBetween(double.parse(snapshot.data!.docs[index]['latitude']!), double.parse(snapshot.data!.docs[index]['longitude']!), currPoss.latitude, currPoss.longitude) + 4) / 1000)
                                                      .toStringAsFixed(3)
                                                      .toString() +
                                                  " kms")
                                              : (((Geolocator.distanceBetween(double.parse(snapshot.data!.docs[index]['latitude']!), double.parse(snapshot.data!.docs[index]['longitude']!), currPoss.latitude, currPoss.longitude) + 1) /
                                                          1000)
                                                      .toStringAsFixed(3)
                                                      .toString() +
                                                  " kms"),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: setColors.white
                                                .withOpacity(0.9),
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
            }));
  }
}
