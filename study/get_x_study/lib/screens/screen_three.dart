import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenThree extends StatefulWidget {
  const ScreenThree({Key? key}) : super(key: key);

  @override
  _ScreenThreeState createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  int _radioValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Three'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildRadioButton(0),
          _buildRadioButton(1),
          _buildRadioButton(2),
          ElevatedButton(
            onPressed: () {
              Get.back(result: _radioValue);
            },
            child: Text('Back'),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioButton(int value) {
    return Row(
      children: <Widget>[
        Radio(
          value: value,
          groupValue: _radioValue,
          onChanged: (int? newValue) {
            setState(() { _radioValue = newValue ?? 0; });
          },
        ),
        Text(value.toString()),
      ],
    );
  }
}
