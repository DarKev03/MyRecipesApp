import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/widgets/calendar_widget.dart';


class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

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
            CalendarWidget()
          ],
        ),
      )),
    );
  }
}
