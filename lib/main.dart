import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/providers/auth.dart';
import 'package:sensor_app/providers/devices.dart';
import 'package:sensor_app/routes.dart';
import 'package:sensor_app/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Devices>(
          create: (context) => Devices(),
        ),
        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('en', 'US'),
        ],
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
