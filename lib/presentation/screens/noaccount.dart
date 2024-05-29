// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoAccount extends StatelessWidget {
  final List<Item> items = [
    Item(
      imageUrl: 'https://www.jumio.com/app/uploads/2020/10/ID-US.png',
    ),
    Item(
      imageUrl:
          'https://th.bing.com/th/id/R.a23d6376839899eba3d7648990f34d8a?rik=HEsuS6DJXHM%2bCg&riu=http%3a%2f%2fpngimg.com%2fuploads%2fkey%2fkey_PNG3378.png&ehk=Yu1s6FCMs9b5wv6I7JEhKSZmG0pzUInKvt17AOaXohQ%3d&risl=1&pid=ImgRaw&r=0',
    ),
    Item(
      imageUrl:
          'https://th.bing.com/th/id/R.a23d6376839899eba3d7648990f34d8a?rik=HEsuS6DJXHM%2bCg&riu=http%3a%2f%2fpngimg.com%2fuploads%2fkey%2fkey_PNG3378.png&ehk=Yu1s6FCMs9b5wv6I7JEhKSZmG0pzUInKvt17AOaXohQ%3d&risl=1&pid=ImgRaw&r=0',
    ),
    Item(
      imageUrl:
          'https://th.bing.com/th/id/OIP.3l2nfzcHhMemSZooiH3B3AHaFj?rs=1&pid=ImgDetMain',
    ),
    Item(
      imageUrl:
          'https://th.bing.com/th/id/OIP.3l2nfzcHhMemSZooiH3B3AHaFj?rs=1&pid=ImgDetMain',
    ),
    Item(
      imageUrl:
          'https://th.bing.com/th/id/R.a23d6376839899eba3d7648990f34d8a?rik=HEsuS6DJXHM%2bCg&riu=http%3a%2f%2fpngimg.com%2fuploads%2fkey%2fkey_PNG3378.png&ehk=Yu1s6FCMs9b5wv6I7JEhKSZmG0pzUInKvt17AOaXohQ%3d&risl=1&pid=ImgRaw&r=0',
    ),
    Item(
      imageUrl:
          'https://th.bing.com/th/id/R.a23d6376839899eba3d7648990f34d8a?rik=HEsuS6DJXHM%2bCg&riu=http%3a%2f%2fpngimg.com%2fuploads%2fkey%2fkey_PNG3378.png&ehk=Yu1s6FCMs9b5wv6I7JEhKSZmG0pzUInKvt17AOaXohQ%3d&risl=1&pid=ImgRaw&r=0',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(backgroundColor: Colors.blue[300], actions: [
          // *********************    navigation to the login page here
          TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 17),
                child: Text(
                  'Log In',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 1.3),
                ),
              ))
        ]),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 33,
            children: List.generate(items.length, (index) {
              return GridItem(
                item: items[index],
              );
            }),
          ),
        ));
  }
}

class Item {
  final String imageUrl;

  Item({required this.imageUrl});
}

class GridItem extends StatelessWidget {
  final Item item;

  GridItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 7),
          Expanded(
            child: Image.network(
              item.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  context.go('/login');
                },
                icon: Icon(Icons.read_more),
                style: ButtonStyle(
                    iconColor: MaterialStatePropertyAll(Colors.blue)),
              ),
              IconButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  icon: Icon(Icons.comment),
                  style: ButtonStyle(
                      iconColor: MaterialStatePropertyAll(Colors.blue)))
            ],
          ),
        ],
      ),
    );
  }
}
