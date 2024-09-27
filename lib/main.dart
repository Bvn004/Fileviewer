import 'package:flutter/material.dart';
import 'package:pdfview/excelfile.dart';
import 'package:pdfview/homepage.dart';
import 'package:pdfview/pdfviewer.dart';
import 'package:pdfview/splashscree.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          MaterialApp(debugShowCheckedModeBanner: false, home: Loadingscreen()),
    );
  }
}
