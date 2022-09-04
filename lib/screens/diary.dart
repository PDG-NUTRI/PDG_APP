import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pdg_app/model/meal.dart';
import 'package:pdg_app/provider/meal_provider.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:pdg_app/widgets/cards/arrow_pic_card.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../provider/auth_provider.dart';
import '../widgets/buttons/action_button.dart';
import '../widgets/diary/diary_top_bar.dart';
import '../widgets/diary/top_shape.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  DateTime _selectedDate = DateTime.now();

  _onDaySelected(DateTime day) {
    _selectedDate = day;
  }

  List<Meal> _getEventsForDay(BuildContext context, DateTime day) {
    return context.read<MealProvider>().meals;
  }

  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthProvider>().userUid;
    return ChangeNotifierProvider(
      create: (context) => MealProvider(uid),
      builder: (context, child) {
        context.watch<MealProvider>().meals;

        return Diary(
            onDaySelected: _onDaySelected,
            getDiariesForDay: (day) {
              return _getEventsForDay(context, day);
            },
            clientName: GetIt.I.get<AuthProvider>().user!.firstName,
            onAddPressed: () async {
              final addedMeal = await AutoRouter.of(context)
                  .push<Meal?>(AddMealScreenRoute(day: _selectedDate));
              if (addedMeal != null) {
                // ignore: use_build_context_synchronously
                await context.read<MealProvider>().addMeal(addedMeal);
                // ignore: use_build_context_synchronously
                context.read<MealProvider>().fetchMeals();
              }
            },
            onMealBlocPressed: (Meal meal) {
              AutoRouter.of(context)
                  .push(AddMealScreenRoute(day: _selectedDate, meal: meal));
            });
      },
    );
  }
}

class Diary extends StatefulWidget {
  final double screenWidth;
  final bool showActionButton;
  final List<Meal> Function(DateTime) getDiariesForDay;
  final String clientName;
  final String clientPicturePath;
  final void Function()? _onAddPressed;
  final void Function(DateTime)? _onDaySelected;
  final void Function(Meal)? _onMealBlocPressed;

  const Diary({
    this.screenWidth = 0,
    this.showActionButton = true,
    required this.getDiariesForDay,
    required this.clientName,
    this.clientPicturePath = "assets/images/default_user_pic.png",
    void Function(DateTime)? onDaySelected,
    void Function()? onAddPressed,
    void Function(Meal)? onMealBlocPressed,
    Key? key,
  })  : _onAddPressed = onAddPressed,
        _onDaySelected = onDaySelected,
        _onMealBlocPressed = onMealBlocPressed,
        super(key: key);

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.screenWidth == 0
        ? MediaQuery.of(context).size.width
        : widget.screenWidth;

    final height = (width * 0.6027777777777777).toDouble();

    final background = CustomPaint(
      size: Size(width,
          height), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
      painter: DiaryTopShape(),
    );

    final DateFormat hourFormatter = DateFormat('HH:mm');

    return Stack(children: [
      Column(
        children: [
          DiaryTopBar(
            background: background,
            height: height,
            clientName: widget.clientName,
            clientPicturePath: widget.clientPicturePath,
          ),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2050, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
              if (widget._onDaySelected != null) {
                widget._onDaySelected!(selectedDay);
              }
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: context.read<MealProvider>().getMealsByDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle),
              todayTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onSurface),
              selectedDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle),
            ),
          ),
          const SizedBox(height: 13),
          Expanded(
            child: _CalendarBody(
              hourFormatter: hourFormatter,
              meals: context.read<MealProvider>().getMealsByDay(_selectedDay),
              onMealBlocPressed: widget._onMealBlocPressed,
            ),
          ),
        ],
      ),
      if (widget.showActionButton)
        ActionButton(
          icon: Icons.add,
          onPressed: widget._onAddPressed,
        )
    ]);
  }
}

class _CalendarBody extends StatelessWidget {
  final List<Meal> meals;
  final void Function(Meal)? onMealBlocPressed;

  const _CalendarBody({
    required this.meals,
    Key? key,
    required this.hourFormatter,
    this.onMealBlocPressed,
  }) : super(key: key);

  final DateFormat hourFormatter;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meals.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: onMealBlocPressed != null
              ? (() => onMealBlocPressed!(meals[index]))
              : () {},
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 4.0,
            ),
            child: ArrowPicCard(
              title: Text(meals[index].title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(
                "${hourFormatter.format(meals[index].startTime)} - ${hourFormatter.format(meals[index].endTime)}",
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ),
        );
      },
    );
  }
}
