import 'package:get/get.dart';
import 'package:habittracker/data/habit_database.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/components/my_alert_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeGet extends GetxController {
  HabitDatabase db = HabitDatabase();
  final _newHabitNameController = TextEditingController();
  final myBox = Hive.box("Habit_Database");

  @override
  void onInit() {
    super.onInit();

    // if there is no current habit list, then it is the 1st time ever opening the app
    if (myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      // there already exists data, this is not the first time
      db.loadData();
    }

    // update the database
    db.updateDatabase();
  }

  void checkBoxTapped(bool? value, int index) {
    db.todaysHabitList[index][1] = value;
    db.updateDatabase();
    update();
  }

  void createNewHabit() {
    Get.dialog(
      MyAlertBox(
        controller: _newHabitNameController,
        hintText: 'Enter habit name..',
        onSave: saveNewHabit,
        onCancel: cancelDialogBox,
      ),
    );
  }

  void saveNewHabit() {
    db.todaysHabitList.add([_newHabitNameController.text, false]);
    _newHabitNameController.clear();
    Get.back();
    db.updateDatabase();
    update();
  }

  void cancelDialogBox() {
    _newHabitNameController.clear();
    Get.back();
  }

  void openHabitSettings(int index) {
    Get.dialog(
      MyAlertBox(
        controller: _newHabitNameController,
        hintText: db.todaysHabitList[index][0],
        onSave: () => saveExistingHabit(index),
        onCancel: cancelDialogBox,
      ),
    );
  }

  void saveExistingHabit(int index) {
    db.todaysHabitList[index][0] = _newHabitNameController.text;
    _newHabitNameController.clear();
    Get.back();
    db.updateDatabase();
    update();
  }

  void deleteHabit(int index) {
    db.todaysHabitList.removeAt(index);
    db.updateDatabase();
    update();
  }

  Box get box => myBox; // Getter for myBox
}
