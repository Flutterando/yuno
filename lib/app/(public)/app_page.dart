import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routefly/routefly.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 1), () {
        Routefly.navigate('/home');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text(
          'YuNO',
          style: GoogleFonts.lemon(
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
