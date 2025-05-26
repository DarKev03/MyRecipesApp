import 'package:flutter/material.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TableCalendar.new(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              currentDay: DateTime.now(),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                final recipeViewModel = context.read<RecipeViewModel>();
                recipeViewModel.setRecipesPerDay(selectedDay);

                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                        child: Text(
                            "${selectedDay.day} ${selectedDay.month} ${selectedDay.year}")));
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: const Color.fromARGB(113, 216, 30, 92),
                  shape: BoxShape.circle,
                ),
                defaultTextStyle:
                    const TextStyle(color: AppColors.secondaryColor),
                weekendTextStyle:
                    const TextStyle(color: Color.fromARGB(151, 35, 57, 91)),
                todayTextStyle: const TextStyle(color: Colors.white),
                selectedTextStyle: const TextStyle(color: Colors.white),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                leftChevronIcon: const Icon(
                  Icons.chevron_left,
                  color: AppColors.secondaryColor,
                ),
                rightChevronIcon: const Icon(
                  Icons.chevron_right,
                  color: AppColors.secondaryColor,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: const TextStyle(color: AppColors.secondaryColor),
                weekendStyle: const TextStyle(color: AppColors.secondaryColor),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
