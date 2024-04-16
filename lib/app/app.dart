
import 'package:flutter/material.dart';

import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  //const MyApp({super.key});// default constructor : can create multiple instance and we don't need this we need singleton or create one instance for all app

  // so we will create named constructor to create object just for once ==> (singleton)
  MyApp._internal(); // so I can't instantiate it out this class like when it was default const and I don't want to create instance outside the class in any different class or function

  static final MyApp _instance = MyApp._internal(); // singleton or single instance
  factory MyApp() => _instance; // factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}

class Person {
  late final String name;
  late final int age;

  Person(this.name, this.age); // default constructor
  // Person(this.name);   // can't do this like java for example ==> this called overloading in java and instead of that in dart we use named constructor
  Person.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.age = json['age'];
  }
}
