import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/controllers/bottom_nav_controller.dart';
import 'package:instagram_clone/src/pages/MyPage.dart';
import 'package:instagram_clone/src/pages/active_history.dart';
import 'package:instagram_clone/src/pages/home.dart';
import 'package:instagram_clone/src/pages/search.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Obx(
            ()=> Scaffold(
            body: IndexedStack(
              index: controller.pageIndex.value,
              children: [
                const Home(),
                Navigator(
                  key: Get.nestedKey(1),
                  onGenerateRoute: (routeSetting){
                    return MaterialPageRoute(builder: (context) => const Search());
                  },
                ),
                Container(child: Center(child: Text('Upload')),),
                const ActiveHistory(),
                const MyPage()
              ],
            ),
            bottomNavigationBar:BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.pageIndex.value,
              elevation:0,
              onTap: controller.changeBottomNav,
              items: [
                BottomNavigationBarItem(icon: ImageData(IconsPath.homeOff), activeIcon: ImageData(IconsPath.homeOn), label: 'home'),
                BottomNavigationBarItem(icon: ImageData(IconsPath.searchOff), activeIcon: ImageData(IconsPath.searchOn), label: 'search'),
                BottomNavigationBarItem(icon: ImageData(IconsPath.uploadIcon), label: 'upload'),
                BottomNavigationBarItem(icon: ImageData(IconsPath.activeOff), activeIcon: ImageData(IconsPath.activeOn), label: 'home'),
                BottomNavigationBarItem(icon: Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey)), label: 'home'),
              ],
            ),
          ),
        ),
        onWillPop: controller.willPopAction);
  }
}
