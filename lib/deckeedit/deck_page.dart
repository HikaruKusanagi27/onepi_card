import 'package:flutter/material.dart';

class DeckPage extends StatefulWidget {
  const DeckPage({super.key});

  @override
  _DeckPageState createState() => _DeckPageState();
}

class _DeckPageState extends State<DeckPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('ダイアログのタイトル'),
            content: Text('ダイアログの内容'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('閉じる')),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
