import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_study/src/provider/count_provider.dart';

class ViewCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<CountProvider>(
        builder: (BuildContext context, CountProvider provider, Widget child) {
          return Text(
            provider.count.toString(),
            style: TextStyle(fontSize: 80),
          );
        },
      ),
    );
  }
}
