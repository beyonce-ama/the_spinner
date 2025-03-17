import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import 'dart:math';

class SpinnerScreen extends StatefulWidget {
  const SpinnerScreen({super.key});

  @override
  State<SpinnerScreen> createState() => _SpinnerScreenState();
}

class _SpinnerScreenState extends State<SpinnerScreen> {
  final TextEditingController _inputController = TextEditingController();
  List<String> selections = [];
  List<String> history = [];
  final StreamController<int> selected = StreamController<int>();
  bool showEntries = true;
  int spinDuration = 2;
  final List<Color> rainbowColors = [
    Colors.red, Colors.orange, Colors.yellow, Colors.green,
    Colors.blue, Colors.indigo, Colors.purple
  ];

  @override
  void initState() {
    super.initState();
    selections = ["Item 1", "Item 2","Item 3", "Item 4", "Item 5","Item 6"];
  }

  void spinWheel() {
    if (selections.isEmpty) return;
    final randomIndex = Random().nextInt(selections.length);
    selected.add(randomIndex);

    Future.delayed(Duration(seconds: spinDuration), () {
      showResultDialog(selections[randomIndex], randomIndex);
    });
  }

  void showResultDialog(String result, int index) {
    setState(() {
      history.add(result);
    });

    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(" $result"),
        content: const Text("result"),
        actions: [
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              removeChoice(index);
            },
          ),
        ],
      ),
    );
  }

  void addChoice() {
    String inputText = _inputController.text.trim();
    if (inputText.isNotEmpty) {
      setState(() {
        if (selections.length < 2) {
          selections.add(inputText);
        } else if (selections.contains("Item 1")) {
          selections[selections.indexOf("Item 1")] = inputText;
        } else if (selections.contains("Item 2")) {
          selections[selections.indexOf("Item 2")] = inputText; 
          } else if (selections.contains("Item 3")) {
          selections[selections.indexOf("Item 3")] = inputText;
        }  else if (selections.contains("Item 4")) {
          selections[selections.indexOf("Item 4")] = inputText; 
          } else if (selections.contains("Item 5")) {
          selections[selections.indexOf("Item 5")] = inputText;
          }else if (selections.contains("Item 6")) {
          selections[selections.indexOf("Item 6")] = inputText;
        
        }else {
          selections.add(inputText);
        }
        _inputController.clear();
      });
    }
  }

  void removeChoice(int index) {
    setState(() {
      selections.removeAt(index);
      if (selections.length < 2) {
        selections.addAll(["item 1"]);
      }
    });
  }

  void shuffleChoices() {
    setState(() {
      selections.shuffle();
    });
  }

 @override
Widget build(BuildContext context) {
  final Brightness brightness = MediaQuery.of(context).platformBrightness;
  final bool isDarkMode = brightness == Brightness.dark;

  return CupertinoPageScaffold(
   navigationBar: CupertinoNavigationBar(
  backgroundColor: isDarkMode ? Colors.black : Colors.deepPurple.shade100,
  middle: Text(
    "Spinner", 
    style: TextStyle(
    color: isDarkMode ? Colors.deepPurple.shade100 : Colors.deepPurple.shade700,
      fontSize: 20, fontWeight: FontWeight.w600),
  ),
  trailing: CupertinoButton(
    padding: EdgeInsets.zero, 
    child: Icon(
      CupertinoIcons.info_circle_fill, 
      color: Colors.deepPurple, 
      size: 26, 
    ),
    onPressed: () {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text("How to Use"),
          content: const Text(
             "1. Tap the wheel to spin it.\n"
            "2. Add choices using the 'Add Choice' button.\n"
            "3. View history to see previous spins.\n"
            "4. Customize your choices anytime!\n"
            "5. Adjust spin duration using the slider.",
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("Got it!"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    },
  ),
),

    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [Colors.black, Colors.deepPurple.shade900]
              : [Colors.deepPurple.shade200, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: spinWheel,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 320,
                      height: 320,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red.shade700,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                        border: Border.all(color: Colors.black, width: 10), 
                      ),
                    ),

                    SizedBox(
                      width: 280,
                      height: 280,
                      child: FortuneWheel(
                        selected: selected.stream,
                        duration: Duration(seconds: spinDuration),
                        items: selections.asMap().entries.map((entry) {
                          int index = entry.key;
                          String choice = entry.value;
                          return FortuneItem(
                            child: Transform.rotate(
                              angle: -((index * (6.28 / selections.length))), 
                              child: Text(
                                choice,
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                            style: FortuneItemStyle(
                              color: rainbowColors[index % rainbowColors.length],
                              borderColor: Colors.black,
                              borderWidth: 2, 
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.grey.shade300],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: Colors.orange, width: 3),
                        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 8)],
                      ),
                    ),

                  
                ],
              ),
            ),

              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      controller: _inputController,
                      placeholder: "Enter a choice...",
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.deepPurple.shade700 : const Color.fromARGB(255, 241, 240, 242),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CupertinoButton(
                color: Colors.deepPurple.shade300,
                onPressed: addChoice,
                child: const Text("Add Choice", style: TextStyle(color: Colors.white)),
              ),
                ],
              ),
              const SizedBox(height: 10),
              CupertinoSlider(
                value: spinDuration.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                activeColor: Colors.deepPurple.shade400,
                onChanged: (value) {
                  setState(() {
                    spinDuration = value.toInt();
                  });
                },
              ),
              Text("Spin Duration: $spinDuration seconds", textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.deepPurple.shade200 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => setState(() => showEntries = true),
                                                color: showEntries ? Colors.deepPurple.shade700 : Colors.deepPurple.shade300,
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Entries",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: showEntries ? Colors.white : Colors.white, 
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: showEntries ? Colors.deepPurple.shade300 : Colors.deepPurple.shade700, 
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "${selections.length}",
                                      style: TextStyle(
                                        color: showEntries ? Colors.white : Colors.white, 
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => setState(() => showEntries = false),
                              color: !showEntries ? Colors.deepPurple.shade700 : Colors.deepPurple.shade300,
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "History",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: !showEntries ? Colors.white : Colors.white, 
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: showEntries ? Colors.deepPurple.shade700 : Colors.deepPurple.shade300, 
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        "${history.length}",
                                        style: TextStyle(
                                          color: !showEntries ? Colors.white : Colors.white, 
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                                          
                      ],
                    ),
                    const Divider(),
                    if (showEntries)...[
                      Align(
                        alignment: Alignment.centerRight,
                        child: CupertinoButton(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          onPressed: shuffleChoices,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(CupertinoIcons.shuffle, size: 18, color: Colors.deepPurple),
                              SizedBox(width: 5),
                              Text("Shuffle", style: TextStyle(color: Colors.deepPurple)),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: selections.map((item) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.deepPurple.shade800 : Colors.deepPurple.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item, style: TextStyle(fontSize: 16,
                              color: isDarkMode ? Colors.deepPurple.shade100 : Colors.deepPurple.shade800,

                               )),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => removeChoice(selections.indexOf(item)),
                                child: const Icon(CupertinoIcons.trash, size: 20, color: CupertinoColors.systemRed),
                              ),
                            ],
                          ),
                        )).toList(),
                      )
                    ]
                    else
                      Column(
                        children: history.map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(item, style: TextStyle(fontSize: 16, 
                          color: isDarkMode ? Colors.deepPurple.shade800 : Colors.deepPurple.shade800,)
                          ),
                        )).toList(),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ),
  );
}


  @override
  void dispose() {
    selected.close();
    super.dispose();
  }
}