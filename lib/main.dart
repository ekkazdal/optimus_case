import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimus_case/home.dart';
import 'package:optimus_case/util/dimen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    Dimen.getSizes(mediaQuery.size.width, mediaQuery.size.height);
    // Sistem rengi ve stil ayarı
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDarkMode ? const Color.fromRGBO(41, 58, 137, 1) : const Color.fromRGBO(212, 222, 241, 1),
        statusBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark, // Light mod teması
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        cardColor: const Color.fromRGBO(212, 222, 241, 1),
        hintColor: Colors.black,
        focusColor: Colors.black,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light, // Dark mod teması
        primaryColor: Colors.red,
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 28, 70),
        cardColor: const Color.fromRGBO(41, 58, 137, 1),
        primaryColorDark: Colors.white,
        hintColor: Colors.white,
        focusColor: Colors.white,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}
