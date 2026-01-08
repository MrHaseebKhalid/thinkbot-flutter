import "package:flutter/material.dart";
import "package:hive_flutter/adapters.dart";
import "package:provider/provider.dart";
import "package:think_bot/Models/user_model.dart";

import "Provider/data_provider.dart";
import "Resources/resources.dart";
import "Screens/Splash/splash1.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox("dataBox");

  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider()..getDataFromHive(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: R.themes.lightTheme,
      darkTheme: R.themes.darkTheme,

      debugShowCheckedModeBanner: false,
      home: const SplashFirst(),
    );
  }
}
