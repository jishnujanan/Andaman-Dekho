import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:app/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';


var isLocationPermissionEnabled = false;

Dio getDio() {
  Dio http = new Dio();
  http.options.baseUrl = "https://us-central1-andaman-dekho.cloudfunctions.net/api";
  http.options.headers['token'] = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IndiQk5xeWtkblhhcmFpZ3F0S1V4IiwiZW1haWwiOiJqaXNoYW50YUBnbWFpbC5jb20iLCJpYXQiOjE2NDA5NTE2MTh9.lpUuOMpiEAHVEIzJQs1KLB0GizMD3GEmcgBGxszT-YQ';
  return http;
}

Position currPoss = Position(longitude: 24.0, latitude: 23.0, timestamp: DateTime.now(), accuracy:  5.0, altitude: 0.0, heading: -1.0, speed: -1.0, speedAccuracy: -1.0);

Future<Position?> setCurrPos() async
{
  // print("before");
  // print(currPoss);
  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((value){
    currPoss = value;
    //currPoss=Position(longitude: 11.623377, latitude: 92.726486, timestamp: DateTime.now(), accuracy:  5.0, altitude: 0.0, heading: -1.0, speed: -1.0, speedAccuracy: -1.0);
    print("current position is $currPoss");
    return currPoss;
    //print("current position is $currPoss");
    // print("after");
    // print(value);
  });
}

Widget getLoadingWidget({size=70.0})
{
  return Center(
    child: SpinKitDoubleBounce(
      color: setColors.appBar,
      size: size,
    ),
  );
}

double setHeight(context, {factor = 1.0})
{
  return MediaQuery.of(context).size.height*factor;
}

double setWidth(context, {factor = 1.0})
{
  return MediaQuery.of(context).size.width*factor;
}

double getScreenWidth(context)
{
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(context)
{
  return MediaQuery.of(context).size.height;
}



class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
      // Fluttertoast.showToast(
      //     msg: "Url opening",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
    } else {
      // Fluttertoast.showToast(
      //     msg: "Error opening url",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
    }
  }
}
