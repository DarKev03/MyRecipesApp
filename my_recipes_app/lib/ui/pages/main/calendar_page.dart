import 'package:flutter/material.dart';
import 'package:my_recipes_app/l10n/app_localizations.dart';
import 'package:my_recipes_app/ui/widgets/calendar_widget.dart';
import 'package:my_recipes_app/ui/widgets/next_recipes_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              CalendarWidget(),
              SizedBox(
                height: 50,
              ),

              //Proximas planificaciones
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(AppLocalizations.of(context)!.upcomingPlannings,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryColor)),
              ),
              NextRecipesWidget(),
            ],
          ),
        )),
      ),
    );
  }
}
