import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/components/habit_tile.dart';
import 'package:habittracker/components/month_summary.dart';
import 'package:habittracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:habittracker/getX/Homepage_get.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Themeprovider>(context);
    final HomeGet controller = Get.put(HomeGet());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: themeProvider.themedata.colorScheme.onPrimary,
        backgroundColor: themeProvider.themedata.colorScheme.primary,
        title: Text(
          "Habit Tracker",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themeProvider.themedata.colorScheme.onPrimary,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: themeProvider.themedata.colorScheme.background,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoSwitch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
              const SizedBox(height: 10),
              Text(
                "Light         Dark",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: themeProvider.themedata.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: themeProvider.themedata.colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: controller.createNewHabit,
        backgroundColor: theme.colorScheme.primary,
        child: Icon(Icons.add, color: theme.colorScheme.onPrimary),
      ),
      body: GetBuilder<HomeGet>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MonthlySummary(
                datasets: controller.db.heatMapDataSet,
                startDate: controller.box.get("START_DATE"),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.db.todaysHabitList.length,
                  itemBuilder: (context, index) {
                    return HabitTile(
                      habitName: controller.db.todaysHabitList[index][0],
                      habitCompleted: controller.db.todaysHabitList[index][1],
                      onChanged: (value) =>
                          controller.checkBoxTapped(value, index),
                      settingsTapped: (context) =>
                          controller.openHabitSettings(index),
                      deleteTapped: (context) => controller.deleteHabit(index),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, bottom: 8.0),
                child: Text(
                  "Add New Habits and Slide the Habit tile for options",
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
