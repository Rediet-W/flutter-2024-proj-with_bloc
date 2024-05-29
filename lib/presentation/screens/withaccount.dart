// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WithAccount extends StatelessWidget {
  final List<Item> items = [
    Item(
      imageUrl: 'https://www.jumio.com/app/uploads/2020/10/ID-US.png',
      description:
          'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
    ),
    Item(
      imageUrl:
          'https://th.bing.com/th/id/R.a23d6376839899eba3d7648990f34d8a?rik=HEsuS6DJXHM%2bCg&riu=http%3a%2f%2fpngimg.com%2fuploads%2fkey%2fkey_PNG3378.png&ehk=Yu1s6FCMs9b5wv6I7JEhKSZmG0pzUInKvt17AOaXohQ%3d&risl=1&pid=ImgRaw&r=0',
      description:
          'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
    ),
    Item(
      imageUrl:
          'https://th.bing.com/th/id/R.a23d6376839899eba3d7648990f34d8a?rik=HEsuS6DJXHM%2bCg&riu=http%3a%2f%2fpngimg.com%2fuploads%2fkey%2fkey_PNG3378.png&ehk=Yu1s6FCMs9b5wv6I7JEhKSZmG0pzUInKvt17AOaXohQ%3d&risl=1&pid=ImgRaw&r=0',
      description:
          'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
    ),
    Item(
      imageUrl:
          'https://th.bing.com/th/id/OIP.3l2nfzcHhMemSZooiH3B3AHaFj?rs=1&pid=ImgDetMain',
      description:
          'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
    ),
    Item(
      imageUrl: 'https://www.jumio.com/app/uploads/2020/10/ID-US.png',
      description:
          'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
    ),
    Item(
      imageUrl:
          'https://th.bing.com/th/id/R.a23d6376839899eba3d7648990f34d8a?rik=HEsuS6DJXHM%2bCg&riu=http%3a%2f%2fpngimg.com%2fuploads%2fkey%2fkey_PNG3378.png&ehk=Yu1s6FCMs9b5wv6I7JEhKSZmG0pzUInKvt17AOaXohQ%3d&risl=1&pid=ImgRaw&r=0',
      description:
          'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
    ),
    Item(
      imageUrl:
          'https://th.bing.com/th/id/R.a23d6376839899eba3d7648990f34d8a?rik=HEsuS6DJXHM%2bCg&riu=http%3a%2f%2fpngimg.com%2fuploads%2fkey%2fkey_PNG3378.png&ehk=Yu1s6FCMs9b5wv6I7JEhKSZmG0pzUInKvt17AOaXohQ%3d&risl=1&pid=ImgRaw&r=0',
      description:
          'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
            child: Text(
              'Home',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Colors.white,
                  letterSpacing: 1.3),
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back,
          ),
          style: ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.white)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: GridView.count(
          crossAxisCount: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 30,
          children: List.generate(items.length, (index) {
            return GridItem(
              item: items[index],
            );
          }),
        ),
      ),
    );
  }
}

class Item {
  final String imageUrl;
  final String description;

  Item({required this.imageUrl, required this.description});
}

class GridItem extends StatelessWidget {
  final Item item;

  GridItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/detail');
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 1,
            ),
            Expanded(
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.description,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.go('/comment');
                  },
                  child: Icon(Icons.comment),
                  style: ButtonStyle(
                      iconColor: MaterialStatePropertyAll(Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
