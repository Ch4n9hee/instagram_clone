import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  List<AssetPathEntity> albums = [];
  List<AssetEntity> imageList = [];
  AssetEntity? selectedImage;

  String headerTitle = "";

  @override
  initState() {
    _loadPhotos();
    super.initState();
  }

  Future<void> _loadPhotos() async {
    final result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
            imageOption: const FilterOption(
              sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
            ),
            orders: [
              const OrderOption(type: OrderOptionType.createDate, asc: false),
            ]),
      );
      _loadData();
    } else {}
  }

  Future<void> _loadData() async {
    headerTitle = albums.first.name;
    await _pagingPhotos();
  }

  Future<void> _pagingPhotos() async {
    imageList = await albums.first.getAssetListPaged(page: 0, size: 20);
    selectedImage = imageList.first;
    update();
  }

  void update() => setState(() {});

  Widget _imagePreview() {
    return Container(
      width: Get.width,
      height: Get.width,
      color: Colors.grey,
      child: selectedImage == null ? SizedBox.shrink() : _photoWidget(selectedImage!, 1080),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                context: context,
                builder: (_) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Center(
                      child: Container(
                    margin: const EdgeInsets.only(top: 7),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black54),
                    width: 40,
                    height: 4,
                  )),
                  Expanded(
                    child: ListView(
                      children: List.generate(
                          albums.length, (index) => Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), child: Text(albums[index].name))),
                    ),
                  ),
                ]),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Text(
                    headerTitle,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(color: Color(0xff808080), borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    const Text(
                      '여러 항목 선택',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    ImageData(IconsPath.imageSelectIcon),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xff808080)),
                child: ImageData(IconsPath.cameraIcon),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: imageList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 1, crossAxisSpacing: 1, childAspectRatio: 1),
        itemBuilder: (context, index) => _photoWidget(imageList[index], 200, true));
  }

  Widget _photoWidget(AssetEntity asset, int size, [bool gridImage = false]) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(
        ThumbnailSize(size, size),
      ),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: () {
              if (gridImage == true) {
                selectedImage = asset;
                update();
              }
            },
            child: Opacity(
                opacity: asset == selectedImage && gridImage ? 0.3 : 1,
                child: Image.memory(
                  snapshot.data!,
                  fit: BoxFit.cover,
                )),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.closeImage),
          ),
        ),
        title: const Text(
          'New Post',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.nextImage,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    );
  }
}
