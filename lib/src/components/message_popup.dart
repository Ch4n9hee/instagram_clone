import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePopup extends StatelessWidget {
  final String title;
  final String message;
  final Function() okCallback;
  final Function()? cancelCallback;

  const MessagePopup({Key? key, required this.title, required this.message, required this.okCallback, this.cancelCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: Get.width * 0.7,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
                  ),
                  SizedBox(height: 7,),
                  Text(
                    message,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: okCallback, child: Text('확인')),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.grey), onPressed: cancelCallback, child: Text('취소')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
