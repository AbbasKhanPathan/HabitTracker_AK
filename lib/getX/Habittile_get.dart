import 'package:get/get.dart';

class HabitTileGet extends GetxController {
  final String habitName;
  var habitCompleted = false.obs;

  HabitTileGet({required this.habitName, required bool habitCompleted}) {
    this.habitCompleted.value = habitCompleted;
  }

  void toggleCompleted(bool? value) {
    habitCompleted.value = value ?? false;
    
  }
}
