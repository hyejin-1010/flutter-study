import 'package:cupertino_app/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'model/app_state_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppStateModel>(
      create: (context) => AppStateModel()..loadProducts(),
      child: CupertinoStoreApp(),
    ),
  );
}
