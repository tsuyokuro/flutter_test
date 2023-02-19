import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Test"),
      ),
      body: ListPageBody(),
    );
  }
}

class ListPageBody extends StatelessWidget {
  ListPageBody({super.key});

  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> itemList = [];

    itemList.add(Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "タイトル",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text("Sub title"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Toggle"),
                Switch(
                  value: _isToggled,
                  onChanged: (bool newValue) {
                    _isToggled = newValue;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));

    return Center(
      child: SizedBox(
        width: 500,
        height: 600,
        child: ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (context, i) => itemList[i],
        ),
      ),
    );
  }
}
