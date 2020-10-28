import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/base_screen.dart';
import 'package:sensor_app/providers/senders.dart';
import 'package:sensor_app/providers/sensors.dart';
import 'package:sensor_app/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Senders>(
          create: (context) => Senders(),
        ),
        ChangeNotifierProvider<Sensors>(
          create: (context) => Sensors(),
        )
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
        initialRoute: BaseScreen.routeName,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
