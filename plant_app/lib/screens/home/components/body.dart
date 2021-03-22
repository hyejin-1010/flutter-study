import 'package:flutter/material.dart';
import 'package:plant_app/constaints.dart';
import 'package:plant_app/screens/home/components/featurred_plants.dart';
import 'package:plant_app/screens/home/components/header_with_searchbox.dart';
import 'package:plant_app/screens/home/components/recomend_plants.dart';
import 'package:plant_app/screens/home/components/title_with_more_btn.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // It will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    // it enable scrolling on small device
     return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TitleWidthMoreBtn(
            title: "Recomended",
            press: () {},
          ),
          // It will cover 40% of our total width
          RecomendsPlants(),
          TitleWidthMoreBtn(
            title: "Featured Plants",
            press: () {},
          ),
          FeaturedPlants(),
          SizedBox(
            height: kDefaultPadding,
          )
        ],
      ),
    );
  }
}
