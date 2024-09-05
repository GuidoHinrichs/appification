import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'drink_water/notification_service.dart';
import 'drink_water/water_intake_settings.dart';
import 'drink_water/notification_plan_screen.dart';
import 'go_to_github/about_page.dart';
import 'milestone/kurzprofil_screen.dart';
import 'theme_provider.dart';
import 'animated_background.dart';
import 'drawer_widget.dart';
import 'icebreaker/icebreaker.dart';
import 'info_screen.dart';
import 'meet_your_colleague/meet_your_colleague.dart';
import 'stop_smoking/survey_screen.dart';
import 'intro_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Zeitzonen initialisieren
  tz.initializeTimeZones();

  // Instanziere FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialisierungseinstellungen für das Plugin
  const InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(),
  );

  // Plugin initialisieren und optionalen Callback für Benachrichtigungstaps festlegen
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {},
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => NotificationService(
            flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Appification',
          theme: themeProvider.currentTheme,
          darkTheme: ThemeData(
            primarySwatch: Colors.blue,
            colorScheme: const ColorScheme.dark(
              primary: Colors.blue,
              onPrimary: Colors.black,
              surface: Colors.black26,
              onSurface: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.black,
          ),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          initialRoute: '/intro',
          routes: {
            '/intro': (context) => const IntroScreen(),
            '/home': (context) => const MyHomePage(
                  title: 'Appification',
                ),
            '/page1': (context) => const Icebreaker(),
            '/page2': (context) => const PhoningScreen(),
            '/page3': (context) => const AboutPage(),
            '/page4': (context) => const SurveyScreen(),
            '/page5': (context) => const WaterIntakeSettings(),
            '/page6': (context) => const KurzprofilScreen(),
            '/notificationPlan': (context) =>
                const NotificationPlanScreen(calculatedIntake: 0.0),
            '/info': (context) => const InfoScreen(),
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final double screenWidth = MediaQuery.of(context).size.width;

    // Festlegen einer maximalen Breite für das GridView, um sicherzustellen,
    // dass das Layout auf größeren Bildschirmen nicht zu breit wird
    final double maxGridWidth = screenWidth > 600 ? 600 : screenWidth * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              widget.title,
            ),
            const SizedBox(width: 10),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/info');
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          const Positioned.fill(
            child: AnimatedBackground(),
          ),
          Center(
            child: Container(
              width: maxGridWidth,
              child: SingleChildScrollView(
                // Ermöglicht vertikales Scrollen bei Überlauf
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildButtonWithCircularImage(
                          context,
                          'Quizz-App',
                          '/page1',
                          themeProvider,
                          'assets/images/denken.jpg',
                        ),
                        _buildButtonWithCircularImage(
                          context,
                          'MeetYourColleague',
                          '/page2',
                          themeProvider,
                          'assets/images/telefonieren.jpg',
                        ),
                        _buildButtonWithCircularImage(
                          context,
                          'path to GitHub',
                          '/page3',
                          themeProvider,
                          'assets/images/flutter_dash.jpg',
                        ),
                        _buildButtonWithCircularImage(
                          context,
                          'StopSmoking',
                          '/page4',
                          themeProvider,
                          'assets/images/rauchfrei.jpg',
                        ),
                        _buildButtonWithCircularImage(
                          context,
                          'DrinkWater',
                          '/page5',
                          themeProvider,
                          'assets/images/wasser.jpg',
                        ),
                        _buildButtonWithCircularImage(
                          context,
                          'Milestones',
                          '/page6',
                          themeProvider,
                          'assets/images/meII.jpg',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonWithCircularImage(
    BuildContext context,
    String label,
    String route,
    ThemeProvider themeProvider,
    String imagePath,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(4, 4),
                blurRadius: 10,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.7),
                offset: const Offset(-4, -4),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              textStyle: themeProvider.currentTheme.textTheme.labelLarge,
              minimumSize: const Size(240, 150),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 10,
            ),
            child: Stack(
              children: [
                Center(
                  child: ClipOval(
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: 170,
                      height: 170,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: themeProvider.currentTheme.colorScheme.primary
                        .withOpacity(0.5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(
                      label,
                      style: themeProvider.currentTheme.textTheme.labelLarge
                          ?.copyWith(
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: const Offset(1.0, 1.0),
                            blurRadius: 2.0,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
