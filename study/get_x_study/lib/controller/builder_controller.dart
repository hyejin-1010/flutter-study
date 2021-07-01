import 'package:get/get.dart';

class BuilderController extends GetxController {
  int count = 0;

  increment() {
    count++;
    update();
  }
}

class User {
  int id;
  String name;

  User({
    required this.id,
    required this.name,
  });
}

class ReactiveController extends GetxController {
  RxInt count1 = 0.obs;
  var count2 = 0.obs;
  var user = new User(id: 1, name: '혜진').obs;
  var testList = [1, 2, 3, 4, 5].obs;

  get sum => count1.value + count2.value;

  change({
    required int id,
    required String name,
  }) {
    user.update((val) {
      val?.id = id;
      val?.name = name;
    });
  }
  
  @override
  void onInit() {
    super.onInit();
    ever(count1, (_) {
      print('EVER : COUNT1이 변경될 때마다 실행');
    });
    once(count1, (_) {
      print('ONCE : 처음으로 COUNT1이 변경되었음');
    });
    debounce(count1, (_) {
      print('DEBOUNCE : 1초간 디바운스 한 뒤에 실행');
    }, time: Duration(seconds: 1));
    interval(count1, (_) {
      print('INTERVAL : 1초간 인터벌이 지나면 실행');
    }, time: Duration(seconds: 1));
  }
}