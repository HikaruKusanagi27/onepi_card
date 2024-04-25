import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onepi_app/deckeedit/editdetail_page.dart';

class DeckEditPage extends StatelessWidget {
  const DeckEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('リーダーカード選択'),
          ),
          body: FutureBuilder<List<Map<String, dynamic>>>(
            future: getImageData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Map<String, dynamic>> cardDataList = snapshot.data!;

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // 4列のグリッド
                    // crossAxisSpacing: 10, // 横方向のスペース
                    // mainAxisSpacing: 10, // 縦方向のスペース
                  ),
                  itemCount: cardDataList.length,
                  itemBuilder: (context, index) {
                    String imageUrl = cardDataList[index]['imageURL'];

                    return InkWell(
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
                                    child: Image.network(imageUrl),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          '閉じる',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditDetailPage(
                                                cardData: cardDataList[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'このリーダーを選択しますか？',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
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
                      child: Image.network(imageUrl),
                    );
                  },
                );
              }
            },
          )),
    );
  }
}

Future<List<Map<String, dynamic>>> getImageData() async {
  List<Map<String, dynamic>> cardDataList = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Firebaseからデータを取得する処理
  QuerySnapshot querySnapshot = await firestore.collection('cardlist').get();
  for (var doc in querySnapshot.docs) {
    String imageUrl = doc['imageURL'];
    String name = doc['name'];
    String character0 = doc['character0'];
    String character1 = doc['character1'];
    String character2 = doc['character2'];
    String character3 = doc['character3'];
    String character4 = doc['character4'];
    String character5 = doc['character5'];
    cardDataList.add({
      'imageURL': imageUrl,
      'name': name,
      'character0': character0,
      'character1': character1,
      'character2': character2,
      'character3': character3,
      'character4': character4,
      'character5': character5,
    });
  }

  return cardDataList;
}
