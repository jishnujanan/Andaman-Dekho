import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import '../helpers.dart';

class AboutAndaman extends StatelessWidget {
  const AboutAndaman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = setHeight(context, factor: 1);
    double width = setWidth(context, factor: 1);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        automaticallyImplyLeading: true,
        backgroundColor: setColors.appBar,
        title: const Text(
          "About Andaman",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: height * 0.2,
                child: Image.asset('assets/logo/LIGHT-LOGO.png'),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black,
            ),
            Container(
              padding: EdgeInsets.only(
                  top: height * 0.02, left: width * 0.04, right: width * 0.04),
              child: const Text(
                "The Andaman and Nicobar Islands, located in the east of the Indian mainland geographically, is a splendid island in the Bay of Bengal. Once a hill range extending from Myanmar to Indonesia, these picturesque undulating islands, islets numbering around 572, are covered with dense rain-fed, damp and evergreen forests and endless varieties of exotic flora and fauna.The Andaman and Nicobar Islands have been declared as two of the 218 endemic bird area of the world. As many as 270 species and sub-species of birds have been reported existing in these islands, 106 of them being endemic. The Andaman Wood Pigeon, Andaman Padauk and Dugong are declared as State Bird, State Tree and State Animal respectively. There are about 96 Wildlife Sanctuaries, nine National Parks and one Biosphere Reserve in the islands. These islands are blessed with the bounties of both south-west and north-east monsoons.Most of these islands (about 550) are in the Andaman Group, 28 of which are inhabited. The smaller Nicobars, comprise some 22 main islands (10 inhabited). The Andaman and Nicobars are separated by the Ten Degree Channel which is 150 Kms. wide.  These islands also boast of freedom fighting days’ historically significant landmarks viz. Cellular Jail, Ross Island, Viper Island, Hopetown and Mount Harriet.Andaman and Nicobar Islands have been recognised as an eco-friendly tourist’s destination. As a tourist paradise, these islands have something very special to offer like Cellular Jail, Ross Island and Havelock Island. The Andaman tropical evergreen rain forests, beautiful silver sandy beaches, serpentine mangrove-lines creeks, marine life abounding in rare species of plants, animals, corals, etc., provide a memorable experience to the tourists. There is tremendous scope for enjoying nature in the beach resorts, water sports and adventure water sports, adventure tourism like trekking, Island camping, Nature trail, Scuba Diving, etc.",
                style: TextStyle(fontSize: 18, height: 1.2, wordSpacing: 1.2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
