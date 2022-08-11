import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({Key? key}) : super(key: key);

  Widget _activeItemOne() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          AvatarWidget(size: 40, type: AvatarType.type2, thumbPath: 'https://letsenhance.io/static/b8eda2f8914d307d52f725199fb0c5e6/62e7b/MainBefore.jpg'),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
            child: Text.rich(
              TextSpan(text: '규섭님', style: TextStyle(fontWeight: FontWeight.bold), children: [
                  TextSpan(text: '님이 회원님의 게시물을 좋아합니다. ', style: TextStyle(fontWeight: FontWeight.normal),),
                  TextSpan(text: '5 일전', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: Colors.black54),),
              ]),
            ),
          ),
        ],
      ),
    );
  }


  Widget _newRecently(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          '활동',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _newRecently('오늘'),
            _newRecently('이번주'),
            _newRecently('이번달'),
          ],
        ),
      ),
    );
  }
}
