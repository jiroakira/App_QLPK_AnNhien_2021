import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselModel {
  String image;

  Color color;

  CarouselModel(this.image, this.color);
}

List<CarouselModel> carousels = carouselsData
    .map((item) => CarouselModel(item['image'], item['color']))
    .toList();

var carouselsData = [
  {'image': "assets/images/", 'color': Colors.blue},
  {'image': "assets/images/", 'color': Colors.indigo},
  {'image': "assets/images/", 'color': Colors.pink},
];
