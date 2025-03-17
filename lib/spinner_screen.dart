import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpinnerScreen extends StatefulWidget {
  const SpinnerScreen({super.key});

  @override
  State<SpinnerScreen> createState() => _SpinnerScreenState();
}

class _SpinnerScreenState extends State<SpinnerScreen> {
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
      fontSize: 20, fontWeight: FontWeight.w600),
  ),
  trailing: CupertinoButton(
    padding: EdgeInsets.zero, 
    child: Icon(
      CupertinoIcons.info_circle_fill, 
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
              Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
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
                onPressed: () {  },
                child: const Text("Add Choice", style: TextStyle(color: Colors.white)),
              ),
                ],
              ),
              const SizedBox(height: 10),
              CupertinoSlider(
                min: 1,
                max: 10,
                divisions: 9,
                 value: null, 
                 onChanged: (double value) {  },
              ),
              Text("Spin Duration: seconds", textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            borderRadius: BorderRadius.circular(10),
                            onPressed: () {  },
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
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
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
                              borderRadius: BorderRadius.circular(10),
                              onPressed: () {  },
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
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
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
                          onPressed: () {  },
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
                                onPressed: () {  },
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
  )
}
}