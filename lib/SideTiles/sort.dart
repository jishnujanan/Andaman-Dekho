import 'package:app/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
class Sort
{
  static bubbleSort(List<Map<String,dynamic>>? array) {
    int lengthOfArray = array!.length;
    for (int i = 0; i < lengthOfArray - 1; i++) {
      for (int j = 0; j < lengthOfArray - i - 1; j++) {
        if ((Geolocator.distanceBetween(
          double.parse(array[j]['latitude']!),
          double.parse(array[j]['longitude']!),
          currPoss.latitude,
          currPoss.longitude,
        ) /
            1000)
            .toDouble() >
            (Geolocator.distanceBetween(
              double.parse(array[j + 1]['latitude']!),
              double.parse(array[j + 1]['longitude']!),
              currPoss.latitude,
              currPoss.longitude,
            ) /
                1000)
                .toDouble()) {
          // Swapping using temporary variable
          Map<String,dynamic> temp = array[j];
          array[j] = array[j + 1];
          array[j + 1] = temp;
        }
      }
    }
    return (array);
  }
}