import 'package:flutter/material.dart';

class EditDetailPage extends StatefulWidget {
  final Map<String, dynamic> cardData;
  const EditDetailPage({
    super.key,
    required this.cardData,
  });

  @override
  _EditDetailPageState createState() => _EditDetailPageState();
}

class _EditDetailPageState extends State<EditDetailPage> {
  Map<String, int> cardCountMap = {};

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.cardData['name']),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: AlertDialog(
                            title: Text('デッキ名: 赤ルフィ'),
                            content: Text('50枚'),
                            actions: [
                              Column(
                                children: [
                                  Text('リーダーカード'),
                                  SizedBox(
                                      width: 120,
                                      child: Image.network(
                                          widget.cardData['imageURL'])),
                                  Text('キャラクターカード'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 120,
                                          child: Image.network(
                                              widget.cardData['imageURL'])),
                                      SizedBox(
                                          width: 120,
                                          child: Image.network(
                                              widget.cardData['imageURL'])),
                                    ],
                                  ),
                                  Text('イベントカード'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 120,
                                          child: Image.network(
                                              widget.cardData['imageURL'])),
                                      SizedBox(
                                          width: 120,
                                          child: Image.network(
                                              widget.cardData['imageURL'])),
                                    ],
                                  ),
                                  Text('ステージカード'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 120,
                                          child: Image.network(
                                              widget.cardData['imageURL'])),
                                      SizedBox(
                                          width: 120,
                                          child: Image.network(
                                              widget.cardData['imageURL'])),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('閉じる'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('デッキを作成'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.list,
                    size: 40,
                  ),
                ),
              ],
            ),
            const Text(
              'リーダー',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                width: 120,
                child: Column(
                  children: [
                    Image.network(widget.cardData['imageURL']),
                  ],
                )),
            const Text(
              'キャラクター',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 510,
              width: 420,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: widget.cardData.length,
                itemBuilder: (context, index) {
                  final characterKey = 'character$index';
                  final int initialCount =
                      cardCountMap.containsKey(characterKey)
                          ? cardCountMap[characterKey]!
                          : 0; // カウントマップから初期値を取得する

                  return widget.cardData.containsKey(characterKey)
                      ? InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  // ダイアログ内のテキストを更新するための状態
                                  int dialogCount = initialCount;

                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Image.network(
                                              widget.cardData[characterKey]),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (dialogCount > 0) {
                                                    dialogCount--; // 減らす
                                                    cardCountMap[characterKey] =
                                                        dialogCount; // カウントマップを更新する
                                                  }
                                                });
                                              },
                                              child: const Text(
                                                '減らす',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Text(
                                              '$dialogCount枚',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  backgroundColor: Colors.white,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(width: 20),
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  dialogCount++; // 増やす
                                                  cardCountMap[characterKey] =
                                                      dialogCount; // カウントマップを更新する
                                                });
                                              },
                                              child: const Text(
                                                '増やす',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              },
                            );
                          },
                          child: Image.network(widget.cardData[characterKey]))
                      : Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
