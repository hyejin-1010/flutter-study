import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyFormValidation(),
  ));
}

class MyFormValidation extends StatefulWidget {
  @override
  _MyFormValidationState createState() => _MyFormValidationState();
}

class _MyFormValidationState extends State<MyFormValidation> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return '공백은 허용되지 않습니다.';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(content: Text('처리 중')));
                  }
                },
                child: Text('완료'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
