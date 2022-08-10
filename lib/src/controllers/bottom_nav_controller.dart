import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/message_popup.dart';
import 'package:instagram_clone/src/pages/upload.dart';

enum PageName { home, search, upload, activity, myPage }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxList<int> bottomHistory = [0].obs;

  void changeBottomNav(int value, {bool hasGesture = true}) {
    final page = PageName.values[value];
    switch (page) {
      case PageName.upload:
        Get.to(() => const Upload());
        break;
      case PageName.home:
      case PageName.search:
      case PageName.activity:
      case PageName.myPage:
        _changePage(value);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
    }
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                title: '시스템',
                message: '종료하시겠습니까?',
                okCallback: () {
                  exit(0);
                },
            cancelCallback: Get.back,
              ));
      return false;
    } else {
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomNav(index, hasGesture: false);
      return false;
    }
  }

  @override
  void onInit() {
    ever(bottomHistory, (value) {
      print(value);
    });
    super.onInit();
  }
}
