import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/pages/main/recipe_page.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeViewModel>(
        builder: (context, RecipeViewModel recipeViewModel, child) {
      var recipesPerDay = recipeViewModel.recipesPerDay;
      var calendarRecipes = recipeViewModel.allRecipeCalendars;

      return TableCalendar.new(
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
            recipeViewModel.setRecipesPerDay(selectedDay);
            recipesPerDay = recipeViewModel.recipesPerDay;

            showDialog(
                context: context,
                builder: (context) => Dialog(
                    backgroundColor: AppColors.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: recipesPerDay.isEmpty
                        ? Container(
                            height: 100,
                            width: 200,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(16),
                            child: const Text('No recipes for this day'))
                        : SizedBox(
                            height: 300,
                            width: 300,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: recipesPerDay.length,
                              itemBuilder: (context, index) {
                                final recipe = recipesPerDay[index];
                                return ListTile(
                                  title: Text(
                                    recipe.title!,
                                    style: const TextStyle(
                                        color: AppColors.secondaryColor),
                                  ),
                                  leading: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: AppColors.secondaryColor,
                                    ),
                                    onPressed: () {
                                      recipeViewModel
                                          .deleteRecipeCalendar(recipe.id!);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: AppColors.secondaryColor,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RecipePage(recipe: recipe)));
                                    },
                                  ),
                                  tileColor: Colors.white,
                                  style: ListTileStyle.list,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(                                      
                                      color: AppColors.secondaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                );
                              },
                            ),
                          )));
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              shape: BoxShape.circle,
            ),
            defaultDecoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            weekendDecoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            defaultTextStyle: const TextStyle(color: AppColors.secondaryColor),
            weekendTextStyle:
                const TextStyle(color: Color.fromARGB(151, 35, 57, 91)),
            todayTextStyle: const TextStyle(color: AppColors.primaryColor),
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
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              final hasRecipes = calendarRecipes
                  .any((calendar) => isSameDay(calendar.scheduledDate, day));

              return Container(
                width: 40,
                decoration: BoxDecoration(
                  color: hasRecipes
                      ? AppColors.primaryColor.withOpacity(0.2)
                      : null,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: hasRecipes
                          ? AppColors.primaryColor
                          : AppColors.secondaryColor,
                      fontWeight:
                          hasRecipes ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ));
    });
  }
}
