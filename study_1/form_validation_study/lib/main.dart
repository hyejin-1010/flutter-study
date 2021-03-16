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
  FocusNode nameFocusNode;

  final nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
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
              ),
              TextField(
                controller: nameCtrl,
                focusNode: nameFocusNode,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: '이름을 입력해주세요.',
                  border: InputBorder.none,
                  labelText: '이름',
                ),
              ),
              RaisedButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(nameFocusNode);
                },
                child: Text('Focus'),
              ),
              RaisedButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      content: Text(nameCtrl.text),
                    );
                  });
                },
                child: Text('Done'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
