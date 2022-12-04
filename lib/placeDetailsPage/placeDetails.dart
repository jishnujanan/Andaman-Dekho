import 'package:app/botttomSheet/bottomSheet.dart';
import 'package:app/colors.dart';
import 'package:app/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:readmore/readmore.dart';

class placeDetails extends StatefulWidget {
  final placeName;
  final placeId;
  final Map<String, dynamic>? placedetail;
   placeDetails({this.placedetail, this.placeName, this.placeId});

  @override
  State<placeDetails> createState() => _placeDetailsState();
}

// ignore: camel_case_types
class _placeDetailsState extends State<placeDetails> {
  var isLoading = true;
  var imgList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var temp = [];
    for (int i = 1; i <= widget.placedetail!['images'].length; i++) {
      temp.add(widget.placedetail!['images']['image_' + i.toString()]);
    }
    setState(() {
      imgList = temp;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = getScreenHeight(context);
    double width = getScreenWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const bottomSheet(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: setColors.white),
        elevation: 0.0,
        backgroundColor: setColors.appBar,
        title: Text(
          widget.placeName.toString(),
          style: const TextStyle(color: setColors.white,fontSize: 18),
        ),
      ),
      body: isLoading
          ? Center(child: getLoadingWidget())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.3,
                    padding: EdgeInsets.zero,
                    child: ImageSlideshow(
                      width: double.infinity,
                      initialPage: 0,
                      indicatorColor: setColors.appBar,
                      indicatorBackgroundColor: Colors.black,
                      onPageChanged: (value) {
                        debugPrint('Page changed: $value');
                      },
                      autoPlayInterval: 99999,
                      isLoop: true,
                      children: imgList
                          .map((item) => Image.network(item, fit: BoxFit.fill,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;

                                return getLoadingWidget(size: 20.0);
                              }, width: getScreenWidth(context)))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            widget.placeName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                color: Colors.blueGrey,
                                size: 16.0,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                (Geolocator.distanceBetween(
                                                double.parse(widget
                                                    .placedetail!['latitude']),
                                                double.parse(widget
                                                    .placedetail!['longitude']),
                                                currPoss.latitude,
                                                currPoss.longitude) /
                                            1000)
                                        .roundToDouble()
                                        .toString() +
                                    " kms",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ReadMoreText(
                            widget.placedetail!['description'].toString(),
                            trimLines: 4,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w300),
                            colorClickableText: Colors.black,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'More',
                            trimExpandedText: 'Less',
                            lessStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            moreStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Events Conducted",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ReadMoreText(
                            widget.placedetail!['events_conducted'].toString(),
                            trimLines: 5,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w300),
                            colorClickableText: Colors.black,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'More',
                            trimExpandedText: 'Less',
                            lessStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            moreStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Timings",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ReadMoreText(
                            widget.placedetail!['opening_time'] +
                                "\n" +
                                widget.placedetail!['closing_time'],
                            trimLines: 2,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w300),
                            colorClickableText: Colors.black,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'More',
                            trimExpandedText: 'Less',
                            lessStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            moreStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Entry Fees",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ReadMoreText(
                            widget.placedetail!['entry_fees'].toString(),
                            trimLines: 2,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w300),
                            colorClickableText: Colors.black,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'More',
                            trimExpandedText: 'Less',
                            lessStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            moreStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        )
                        ,Center(
                          child: TextButton(
                            child: const Text("Open in Google Map",style: TextStyle(color: setColors.blue),),
                            onPressed: () {
                              double latitude, longitude;
                              latitude = double.parse(widget.placedetail!['latitude']);
                              longitude = double.parse(widget.placedetail!['longitude']);
                              MapUtils.openMap(latitude, longitude);
                              MapsLauncher.launchCoordinates(latitude, longitude);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
