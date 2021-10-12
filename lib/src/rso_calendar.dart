import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:rso_calendar/src/misc/colors.dart';
import 'package:rso_calendar/src/screens/calendar_tab.dart';
import 'package:rso_calendar/src/screens/home_tab.dart';
import 'package:rso_calendar/src/widgets/sliver_view.dart';

class RSOCalendar extends StatefulWidget {
  const RSOCalendar({Key? key}) : super(key: key);

  @override
  _RSOCalendarState createState() => _RSOCalendarState();
}

class _RSOCalendarState extends State<RSOCalendar> {
  @override
  Widget build(BuildContext context) {
    var darkTheme = const CupertinoThemeData.raw(
      Brightness.dark,
      AppColors.secondaryUofILightest,
      AppColors.secondaryUofILight,
      CupertinoTextThemeData(textStyle: TextStyle(color: Colors.white)),
      AppColors.secondaryUofIDark,
      Colors.black,
    );
    const lightTheme = CupertinoThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      barBackgroundColor: AppColors.secondaryUofILight,
      primaryColor: AppColors.secondaryUofILightest,
    );
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        canvasColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.secondaryUofILight,
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(),
        canvasColor: Colors.black,
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryUofI,
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: PlatformProvider(
        settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
        builder: (context) => PlatformApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          title: "RSO Calendar",
          home: const RSOCalendarTabs(),
          material: (_, __) => MaterialAppData(
            themeMode: ThemeMode.system,
          ),
          cupertino: (ctx, __) => CupertinoAppData(
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}

class RSOCalendarTabs extends StatefulWidget {
  const RSOCalendarTabs({Key? key}) : super(key: key);

  @override
  _RSOCalendarTabsState createState() => _RSOCalendarTabsState();
}

class _RSOCalendarTabsState extends State<RSOCalendarTabs> {
  final GlobalKey<NavigatorState> homeTabKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> calendarTabKey = GlobalKey<NavigatorState>();
  late PlatformTabController tabController;
  late Widget Function(BuildContext, int) contentBuilder;
  final List<String> titles = ["Home", "Calendar"];

  List<BottomNavigationBarItem> navigationBarItems(BuildContext context) => [
        BottomNavigationBarItem(
          icon: Icon(PlatformIcons(context).home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(isMaterial(context)
              ? Icons.calendar_today_rounded
              : CupertinoIcons.calendar),
          label: "Calendar",
        ),
      ];

  @override
  void initState() {
    super.initState();
    final List<Widget> widgets = [
      HomeTab(
        key: homeTabKey,
      ),
      CalendarTab(
        key: calendarTabKey,
      )
    ];

    tabController = PlatformTabController(
      initialIndex: 0,
    );

    contentBuilder = (BuildContext context, int index) => SliverView(
          title: titles[index],
          children: [widgets[index]],
          actions: const [
            SizedBox(),
          ],
          // TODO: implement firebase or shibboleth to get user data to show on the settings page.
          // drawer: SettingsDrawer(),
          leading: null,
        );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformTabScaffold(
      iosContentPadding: true,
      tabController: tabController,
      bodyBuilder: contentBuilder,
      items: navigationBarItems(context),
      cupertinoTabs: (context, platform) => CupertinoTabBarData(
        activeColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? AppColors.secondaryUofILightest
                : AppColors.secondaryUofILight,
        inactiveColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? AppColors.secondaryUofILight
                : AppColors.secondaryUofILightest,
      ),
      materialTabs: (context, platform) => MaterialNavBarData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? AppColors.secondaryUofILightest
                : AppColors.secondaryUofILight,
        unselectedItemColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? AppColors.secondaryUofILight
                : AppColors.secondaryUofILightest,
      ),
    );
  }
}
