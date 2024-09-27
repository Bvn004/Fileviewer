import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfview/homepage.dart';

class Loadingscreen extends StatefulWidget {
  const Loadingscreen({super.key});

  @override
  State<Loadingscreen> createState() => _LoadingscreenState();
}

class _LoadingscreenState extends State<Loadingscreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => Homepage(),
      ));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/pdfimg.png"),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Loading",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  strokeWidth: 3,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ],
          ),
        ));
  }
}
