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
                // Firebaseに登録したデッキリストを表示
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final cardKeys = cardCountMap.keys.toList();
                        return Dialog(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Text(
                                'デッキリスト',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 30),
                              const Text(
                                'リーダー',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  width: 120,
                                  child: Column(
                                    children: [
                                      Image.network(
                                          widget.cardData['imageURL']),
                                    ],
                                  )),
                              SizedBox(height: 30),
                              const Text(
                                'キャラクター',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    // mainAxisSpacing: 10.0, // 任意の間隔を追加できます
                                    // crossAxisSpacing: 10.0,
                                  ),
                                  itemCount: cardKeys.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final characterKey = cardKeys[index];
                                    final count =
                                        cardCountMap[characterKey] ?? 0;
                                    // print(
                                    //     'dialogCount: $count cardCountMap: $cardCountMap');
                                    if (count == 0) {
                                      return SizedBox
                                          .shrink(); // 0枚の場合は何も表示させない
                                    }
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            widget.cardData[characterKey],
                                          ),
                                        ),
                                        Text('$count 枚'),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text(
                    'デッキリスト',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                // Firebaseに登録したデッキリストを表示
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
            Expanded(
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
                  int dialogCount = initialCount; // ダイアログ内のテキストを更新するための状態
                  return widget.cardData.containsKey(characterKey)
                      ? InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
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
                                                // print('dialogCount: $dialogCount, cardCountMap: $cardCountMap');
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
                                                  if (dialogCount < 4) {
                                                    dialogCount++; // 増やす
                                                    cardCountMap[characterKey] =
                                                        dialogCount; // カウントマップを更新する
                                                  }
                                                  // print('dialogCount: $dialogCount, cardCountMap: $cardCountMap');
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
