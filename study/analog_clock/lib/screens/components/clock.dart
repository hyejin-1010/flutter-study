import 'dart:async';
import 'dart:math';

import 'package:analog_clock/constants.dart';
import 'package:analog_clock/providers/my_theme_provider.dart';
import 'package:analog_clock/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'clock_painter.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late MyThemeModel _myThemeModel;
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _myThemeModel = Provider.of<MyThemeModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: kShadowColor.withOpacity(0.14),
                    blurRadius: 64,
                  ),
                ],
              ),
              child: Transform.rotate(
                angle: -pi/2,
                child: CustomPaint(
                  painter: ClickPainter(context: context, dateTime: _dateTime),
                ),
              ),
            ),
          ),
        ),
        Consumer<MyThemeModel>(
          builder: (BuildContext context, MyThemeModel theme, Widget? child) {
            return Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  theme.changeTheme();
                },
                child: SvgPicture.asset(
                  theme.isLightTheme
                    ? 'assets/icons/Sun.svg'
                    : 'assets/icons/Moon.svg',
                  width: 24,
                  height: 24,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
