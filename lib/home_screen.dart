import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _angle = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
  }

  void _spinWheel() {
    setState(() {
      _angle += (Random().nextDouble() * 5 + 5) * pi;
    });

    _controller.forward(from: 0).then((_) {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => const SpinnerScreen()),
      );
    });
  }

@override
Widget build(BuildContext context) {
  final Brightness brightness = MediaQuery.of(context).platformBrightness;
  final bool isDarkMode = brightness == Brightness.dark;

  return CupertinoPageScaffold(
    child: Stack(
      children: [
        // Background
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    "Welcome to Spinner!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Not sure what to choose? Let Spinner decide for you!",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: _spinWheel,
                    child: AnimatedRotation(
                      turns: _angle / (2 * pi),
                      duration: const Duration(seconds: 3),
                      curve: Curves.easeOut,
                      child: Image.asset('images/wheel.png', width: 250, height: 250),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Click the wheel to start!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "This app helps you make quick decisions by randomly selecting from your provided options. Whether it’s picking a meal, choosing a movie, or making any random decision, Spinner has got you covered!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 20, 
          right: 20, 
          child: GestureDetector(
            onTap: () => _showInfoDialog(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                CupertinoIcons.info_circle_fill,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

void _showInfoDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) => Center( 
      child: CupertinoPopupSurface(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,  
          height: 450,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              const Text(
                "Meet the Team", 
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildMemberTile("Beyonce Ama", "images/ama.jpg", "Lead Developer"),
                      _buildMemberTile("Jolas Arpon", "images/arpon.jpg", "Developer"),
                      _buildMemberTile("Monica Carreon", "images/carreon.jpg", "Developer"),
                      _buildMemberTile("Romel Gamboa", "images/gamboa.jpg", "Developer"),
                      _buildMemberTile("Kayle Cedric Larin", "images/5.jpg", "Developer"),
                      _buildMemberTile("Rachelle Anne Macalino", "images/6.jpg", "Developer"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CupertinoButton(
                child: const Text(
                  "Close", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


  Widget _buildMemberTile(String name, String imagePath, String role) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.indigo.shade200,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              Text(role, style: const TextStyle(fontSize: 14, color: CupertinoColors.systemGrey)),
            ],
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
