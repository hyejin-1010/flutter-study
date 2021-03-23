import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widget_study/rabbit.dart';

class StatefulSampleWidget extends StatefulWidget {
  final String title;
  final Rabbit rabbit;
  final int value;

  StatefulSampleWidget({
    this.title,
    this.rabbit,
    this.value,
  });

  @override
  _StatefulSampleWidgetState createState() => _StatefulSampleWidgetState();
}

class _StatefulSampleWidgetState extends State<StatefulSampleWidget> {
  // 최초 한 번만 실행된다.
  // 이 단계에서는 아직 context 가 없기 때문에, context 에 접근할 수 없다.
  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 5), (timer) {
      int index = timer.tick % 4;
      setState(() {
        switch (index) {
          case 0:
            widget.rabbit.updateState(RabbitState.SLEEP);
            break;
          case 1:
            widget.rabbit.updateState(RabbitState.WALK);
            break;
          case 2:
            widget.rabbit.updateState(RabbitState.RUN);
            break;
          case 3:
            widget.rabbit.updateState(RabbitState.EAT);
            break;
        }
      });
    });
  }

  // 최초 한 번만 실행된다. - context 에 접근 가능
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(MediaQuery.of(context).size);
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  void didUpdateWidget(covariant StatefulSampleWidget oldWidget) {
    // 부모의 상태가 변경됐을 때 호출된다.
    // oldWidget: 이전 상태의 나 자신
    super.didUpdateWidget(oldWidget);
    print("oldWidget : ${oldWidget.value}");
    print("Widget : ${widget.value}");
    if (oldWidget.value != widget.value) {
      print("did update widgt");
    }
  }

  @override
  void dispose() {
    print("dispose");
    // TODO: Controller 들 dispose - 안해주면 메모리 누수가 발생할 수 있다.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // UI를 구성 - State 가 변할 때마다(상태변화가 있을 때마다) 호출
    // 가장 빈번하게 호출되는 부분
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Text(
            widget.rabbit.state.toString(),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
