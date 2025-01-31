import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_app/constants/app_routes.dart';
import 'package:restaurant_dicoding_app/widgets/loading_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoadingWidget());
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeRoute);
    });
  }
}
