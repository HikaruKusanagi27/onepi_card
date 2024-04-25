import 'package:flutter/material.dart';

class EditDetailPage extends StatelessWidget {
  final Map<String, dynamic> cardData;
  const EditDetailPage({
    super.key,
    required this.cardData,
  });
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(cardData['name']),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('リーダーカード'),
                    SizedBox(
                        width: 120,
                        child: Column(
                          children: [
                            Image.network(cardData['imageURL']),
                          ],
                        )),
                    const Text('キャラクター'),
                    SizedBox(
                      height: 510,
                      width: 420,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: cardData.length,
                        itemBuilder: (context, index) {
                          final characterKey = 'character$index';
                          return cardData.containsKey(characterKey)
                              ? InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
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
                                                    cardData[characterKey]),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    child: const Text(
                                                      '減らす',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  const Text(
                                                    '0枚',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        backgroundColor:
                                                            Colors.white,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(width: 20),
                                                  ElevatedButton(
                                                    onPressed: () {},
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
                                      },
                                    );
                                  },
                                  child: Image.network(cardData[characterKey]))
                              : Container();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
