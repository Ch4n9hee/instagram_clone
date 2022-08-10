import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<List<int>> groupBox = [[], [], []];
  List<int> groupIndex = [0,0,0];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      final gridIndex = groupIndex.indexOf(min<int>(groupIndex)!);
      int size = 1;
      if(gridIndex != 1){
        size = Random().nextInt(100) % 2 == 0 ? 1 : 2;
      }
      groupBox[gridIndex].add(size);
      groupIndex[gridIndex] += size;
    }
  }

  Widget _appBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffefefef),
            ),
            child: Row(
              children: const [
                Icon(Icons.search),
                Text(
                  '검색',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff838383),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Icon(Icons.location_pin),
        )
      ],
    );
  }

  Widget _body() {
    return Expanded(
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            groupBox.length,
            ((index) => Expanded(
                  child: Column(
                    children: List.generate(
                      groupBox[index].length,
                      (index2) => Container(
                        child: CachedNetworkImage(
                          imageUrl: 'https://thumbs.dreamstime.com/b/cosmos-beauty-deep-space-elements-image-furnished-nasa-science-fiction-art-102581846.jpg',
                          fit: BoxFit.cover,
                        ),
                        height: Get.width * 0.33 * groupBox[index][index2],
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                )),
          ),
        ),
      ),
      // children: [
      //   Expanded(
      //     child: Column(
      //       children: [
      //         Container(
      //           height: 140,
      //           color: Colors.red,
      //         ),
      //       ],
      //     ),
      //   ),
      //   Expanded(
      //       child: Column(
      //     children: [
      //       Container(
      //         height: 140,
      //         color: Colors.blue,
      //       ),
      //     ],
      //   )),
      //   Expanded(
      //       child: Column(
      //     children: [
      //       Container(
      //         height: 140,
      //         color: Colors.grey,
      //       ),
      //     ],
      //   )),
      // ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _appBar(),
            _body(),
          ],
        ),
      ),
    );
  }
}
