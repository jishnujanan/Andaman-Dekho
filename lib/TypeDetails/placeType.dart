import 'package:app/AboutAndaman/aboutandaman.dart';
import 'package:app/SideTiles/airports.dart';
import 'package:app/SideTiles/banks.dart';
import 'package:app/SideTiles/hospitals.dart';
import 'package:app/SideTiles/pharmacy.dart';
import 'package:app/SideTiles/police_station_list.dart';
import 'package:app/botttomSheet/bottomSheet.dart';
import 'package:app/colors.dart';
import 'package:app/helpers.dart';
import 'package:app/placeDetailsPage/placeDetails.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:app/SideTiles/atmList.dart';

import '../AboutUs/aboutus.dart';

class PlaceType extends StatefulWidget {
  final placeType;
  List? categories = [];
  PlaceType({Key? key, this.placeType, this.categories}) : super(key: key);

  @override
  State<PlaceType> createState() => _PlaceTypeState();
}

class _PlaceTypeState extends State<PlaceType> {
  bool isLoading = true;
  var places = [];
  var currSearchPlaces = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCurrPos();
    Dio http = getDio();
    http
        .get(
      "api/place/getPlaceByCategory?category=" + widget.placeType,
    )
        .then((resp) {
      //print(resp.data);
      places = resp.data['message'];

      setState(() {
        currSearchPlaces = places;
        isLoading = false;
      });
    });
  }

  void navigateToPlaceType(place) {
    Navigator.push(
        context,
        PageTransition(
            child: PlaceType(
              placeType: place,
              categories: widget.categories!,
            ),
            type: PageTransitionType.rightToLeftJoined,
            duration: const Duration(milliseconds: 110),
            reverseDuration: const Duration(milliseconds: 110),
            childCurrent: this.widget));
  }

  void navigateToPlaceDetails(Map<String,dynamic> placeDetail, placeName, placeId) {
    Navigator.push(
        context,
        PageTransition(
            child: placeDetails(
              placedetail: placeDetail,
              placeName: placeName,
              placeId: placeId,
            ),
            type: PageTransitionType.rightToLeftJoined,
            duration: const Duration(milliseconds: 110),
            reverseDuration: const Duration(milliseconds: 110),
            childCurrent: this.widget));
  }

  final TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration:  InputDecoration(
        hintText: "Search ${widget.placeType.toString()}",
        border: InputBorder.none,
        hintStyle: const TextStyle(color: setColors.white),
      ),
      style: const TextStyle(color: setColors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              // Navigator.pop(context);
              setState(() {
                _isSearching = false;
              });
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    // ModalRoute.of(context)
    //     .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
    print(searchQuery);
    //print(currSearchPlaces.where((i) => i['placeName']=='Place1').toList());
    setState(() {
      currSearchPlaces = places
          .where((i) => i['placeName']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      currSearchPlaces = places;
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const bottomSheet(),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          children: [
            SizedBox(
              height: setHeight(context, factor: 0.15),
              width: setWidth(context, factor: 0.1),
              child: Center(child: Image.asset('assets/logo/LIGHT-LOGO.png')),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 1,
                color: Colors.black,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount:
                  widget.categories != null ? widget.categories!.length : 0,
              itemBuilder: (context, index) =>
                  widget.categories![index]['categoryName'] != widget.placeType
                      ? ListTile(
                          title:
                              Text(widget.categories![index]['categoryName']),
                          onTap: () {
                            navigateToPlaceType(
                                widget.categories![index]['categoryName']);
                          },
                        )
                      : const SizedBox(height: 0),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 1,
                color: Colors.black,
              ),
            ),
            ListTile(
              title: const Text('ATM'),
              onTap: () {
                //DrawerTapped();
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AtmList(),
                    ));
                // Update the state of the app.
                // ...
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
                // Update the state of the app.
                // ...
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
                // Update the state of the app.
                // ...
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Banks(),
                    ));
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
                      builder: (context) => const Airports(),
                    ));
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
                      builder: (context) => Aboutus(),
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
      appBar: AppBar(
          elevation: 0.0,
          iconTheme: const IconThemeData(color: setColors.white),
          title: _isSearching
              ? _buildSearchField()
              : Text(
                  widget.placeType,
                  style: const TextStyle(color: setColors.white),
                ),
          actions: _buildActions(),
          backgroundColor: setColors.appBar),
      body: isLoading
          ? getLoadingWidget()
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  currSearchPlaces.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(top: 28.0),
                          child: Center(child: Text("No Places Found...")),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: currSearchPlaces.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                navigateToPlaceDetails(
                                    currSearchPlaces[index],
                                    currSearchPlaces[index]['placeName'],
                                    currSearchPlaces[index]['id']);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: SizedBox(
                                        height:
                                            setHeight(context, factor: 0.15),
                                        width: setHeight(context, factor: 0.15),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            currSearchPlaces[index]
                                                ['thumbnail'],
                                            fit: BoxFit.fill,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return getLoadingWidget(
                                                  size: 30.0);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width:setWidth(context,factor: 0.58),
                                            child: Text(
                                              currSearchPlaces[index]
                                                  ['placeName'],
                                              overflow: TextOverflow.visible,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                setWidth(context, factor: 0.5),
                                            child:Text(
                                              currSearchPlaces[index]['description'].toString().substring(0,60)+"....",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.directions_walk,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                (Geolocator.distanceBetween(
                                                                double.parse(
                                                                    currSearchPlaces[
                                                                            index][
                                                                        'latitude']),
                                                                double.parse(
                                                                    currSearchPlaces[
                                                                            index]
                                                                        [
                                                                        'longitude']),
                                                                currPoss
                                                                    .latitude,
                                                                currPoss
                                                                    .longitude) /
                                                            1000)
                                                        .roundToDouble()
                                                        .toString() +
                                                    " kms",
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 25.0,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 25.0,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 25.0,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 25.0,
                                              ),
                                              Icon(
                                                Icons.star_half,
                                                color: Colors.yellow,
                                                size: 25.0,
                                              ),
                                            ],
                                          )
                                          // RatingBar.builder(
                                          //   initialRating: 3,
                                          //   minRating: 1,
                                          //   direction: Axis.horizontal,
                                          //   allowHalfRating: true,
                                          //   itemCount: 5,
                                          //
                                          //   itemBuilder: (context, _) => Icon(
                                          //     Icons.star,
                                          //     color: Colors.amber,
                                          //     size: 0.1,
                                          //   ),
                                          //   onRatingUpdate: (rating) {
                                          //     print(rating);
                                          //   },
                                          // ),
                                        ],
                                      ),
                                    )
                                    // ClipRRect(
                                    //   borderRadius: BorderRadius.circular(10.0),
                                    //   child: InkWell(
                                    //     onTap: () {
                                    //       print("Tapped");
                                    //       navigateToPlaceDetails("Junglee Ghat");
                                    //     },
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.symmetric(
                                    //           horizontal: 4.0, vertical: 2.0),
                                    //       child: Column(
                                    //         children: [
                                    //           Container(
                                    //             height: setHeight(context, factor: 0.2),
                                    //             width: setWidth(context, factor: 0.45),
                                    //             child: ClipRRect(
                                    //               borderRadius: BorderRadius.circular(10.0),
                                    //               child: Image(
                                    //                 fit: BoxFit.cover,
                                    //                 image: NetworkImage(
                                    //                     "https://picsum.photos/seed/picsum/200/300"),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //           SizedBox(
                                    //             height: 2,
                                    //           ),
                                    //           Text(
                                    //             "Junglee Ghat",
                                    //             style: TextStyle(
                                    //                 color: Colors.black,
                                    //                 fontWeight: FontWeight.bold),
                                    //           )
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
    );
  }
}
