import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'publicity_provider.g.dart';

@riverpod
class Publicity extends _$Publicity {
  @override
  bool build() {
    return false;
  }

  void setPublicity(bool value) {
    state = value;
  }

  void toggle() {
    state = !state;
  }
}
