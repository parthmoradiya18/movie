
import 'package:flutter/material.dart';
import 'package:movies/Screens/Home.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Movie_Web_App(),
    ),
  );
}

class Movie_Web_App extends StatefulWidget {
  const Movie_Web_App({Key? key}) : super(key: key);

  @override
  State<Movie_Web_App> createState() => _Movie_Web_AppState();
}

class _Movie_Web_AppState extends State<Movie_Web_App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "PARTH MORADIYA",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Movie Channel Subscription",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Homepage(),
                  ),
                );
              },
              child: const Text(
                "Get TO Started",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}