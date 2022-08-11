import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/image_data.dart';

class SearchFocus extends StatefulWidget {
  const SearchFocus({Key? key}) : super(key: key);

  @override
  State<SearchFocus> createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  Widget _tabMenu(String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        menu,
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  PreferredSizeWidget tabMenu() {
    return PreferredSize(
      child: Container(
        height: AppBar().preferredSize.height,
        width: double.infinity,
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffe4e4e4)))),
        child: TabBar(
          controller: tabController,
          indicatorColor: Colors.black,
          tabs: [
            _tabMenu('인기'),
            _tabMenu('계정'),
            _tabMenu('오디오'),
            _tabMenu('태그'),
            _tabMenu('장소'),
          ],
        ),
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  Widget _body() {
    return TabBarView(
      controller: tabController,
      children: const [
        Center(child: Text('인기 페이지'),),
        Center(child: Text('계정 페이지'),),
        Center(child: Text('오디오 페이지'),),
        Center(child: Text('태그 페이지'),),
        Center(child: Text('장소 페이지'),),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffefefef),
          ),
          child: const TextField(
            decoration: InputDecoration(border: InputBorder.none, hintText: '검색', contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7), isDense: true),
          ),
        ),
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back(id: 1);
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ImageData(IconsPath.backBtnIcon),
          ),
        ),
        bottom: tabMenu(),
      ),
      body: SafeArea(
        child: _body(),
      ),
    );
  }
}
