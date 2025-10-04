import 'package:flutter/material.dart';
import 'package:uniare/deckeedit/deckeedit_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Image.asset(
              'assets/images/img_300694_17.jpg',
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  children: [
                    Text(
                      'ONEPI CARD',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'ONE PERSON ROTATION',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          '一人回しする？',
                        )),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DeckEditPage()),
                          );
                        },
                        child: const Text(
                          'デッキ編集',
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
