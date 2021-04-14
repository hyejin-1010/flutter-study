import 'package:analog_clock/screens/components/body.dart';
import 'package:analog_clock/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Body(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      // 좌측 버튼
      leading: IconButton(
        icon: SvgPicture.asset('assets/icons/Settings.svg'),
        onPressed: () {},
        color: Theme.of(context).iconTheme.color,
      ),
      // 우측 버튼
      actions: [
        _buildAddButton(context)
      ],
    );
  }

  // AppBar - 우측 Add Button
  Padding _buildAddButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: getProportionateScreenWidth(32),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
