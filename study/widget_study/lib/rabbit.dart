class Rabbit {
  String _name;
  RabbitState _state;

  Rabbit({ String name, RabbitState state }) {
    this._name = name;
    this._state = state;
  }

  String get name => _name;
  RabbitState get state => _state;

  updateState(RabbitState state) {
    this._state = state;
  }
}

enum RabbitState {
  SLEEP,
  RUN,
  WALK,
  EAT
}
