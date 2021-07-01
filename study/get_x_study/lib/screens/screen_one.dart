import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_study/screens/screen_four.dart';
import 'package:get_x_study/screens/screen_three.dart';
import 'package:get_x_study/screens/screen_two.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  int _returnData = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () { Get.to(ScreenTwo()); },
              child: Text('Screen Two로 이동'),
            ),
            ElevatedButton(
              onPressed: () { Get.off(ScreenTwo()); },
              child: Text('전 페이지로 돌아가지 못하게 하기'),
            ),
            ElevatedButton(
              onPressed: () { Get.offAll(ScreenTwo()); },
              child: Text('모든 페이지 스택 삭제하기'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('리턴 값 : '),
                Text(_returnData.toString()),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                final resp = await Get.to(ScreenThree());
                setState(() { _returnData = resp; });
              },
              child: Text('리턴값 받아오기'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(ScreenFour(), arguments: '룰루랄라');
              },
              child: Text('아규먼트 보내기'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(
                  ScreenTwo(),
                  transition: Transition.leftToRight,
                );
              },
              child: Text('트랜지션'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/five/1234?id=444');
              },
              child: Text('네임드 라우트'),
            ),
            ElevatedButton(
              onPressed: () {
               Get.snackbar('제목', '내용', snackPosition: SnackPosition.BOTTOM);
              },
              child: Text('SnackBar'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.defaultDialog(middleText: 'Dialog');
              },
              child: Text('Dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    color: Colors.white,
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.music_note),
                          title: Text('Music'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.videocam),
                          title: Text('Video'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Text('Bottom Sheet'),
            ),
          ],
        ),
      ),
    );
  }
}
