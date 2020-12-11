import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/icons/home.png',
      selectedImagePath: 'assets/icons/home.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/icons/list.png',
      selectedImagePath: 'assets/icons/list.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/icons/analytics.png',
      selectedImagePath: 'assets/icons/analytics.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/icons/settings.png',
      selectedImagePath: 'assets/icons/settings.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
