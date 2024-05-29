import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
            child: const Text(
              'Item',
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
          icon: const Icon(
            Icons.arrow_back,
          ),
          style: const ButtonStyle(
              iconColor: MaterialStatePropertyAll(Colors.white)),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 200,
                  color: Colors.blue[300],
                )
              ],
            ),
            Positioned(
                top: 50,
                left: 55,
                child: ClipOval(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'Assets/keys.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Positioned(
                top: 380,
                left: 45,
                child: Container(
                    width: 330,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Center(
                            child: Text(
                              'Item name',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[300],
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: const Column(
                                  children: [
                                    Text(
                                      "Found on ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 238, 238, 238)),
                                    ),
                                    Text(
                                      "April 4, 2024",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Color.fromARGB(
                                              255, 238, 238, 238)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.all(10),
                                child: const Column(
                                  children: [
                                    Text(
                                      "Location ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "5 kilo Lounge",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: const Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sed purus in sapien tempor pulvinar. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nullam molestie, nulla sed scelerisque pharetra, nisi quam fringilla odio, vel porta mauris velit a dolor. Integer nec arcu non elit consequat semper. Sed eui',
                              style: TextStyle(
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start, // Align buttons to the left
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Delete button action
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        side: MaterialStateProperty.resolveWith<
                                            BorderSide>(
                                          (Set<MaterialState> states) {
                                            return const BorderSide(
                                              color: Colors.blue,
                                              width:
                                                  2, // Adjust border width as needed
                                            );
                                          },
                                        ),
                                      ),
                                      child: const Text('Delete'),
                                    ),
                                    const SizedBox(
                                        width:
                                            10), // Add spacing between buttons
                                    ElevatedButton(
                                      onPressed: () {
                                        // Edit button action
                                      },
                                      child: const Text('Edit'),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                        side: MaterialStateProperty.resolveWith<
                                            BorderSide>(
                                          (Set<MaterialState> states) {
                                            return const BorderSide(
                                              color: Colors.white,
                                              width:
                                                  2, // Adjust border width as needed
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Add spacing between buttons and comment button
                                IconButton(
                                  onPressed: () {
                                    context.go('/comment');
                                  },
                                  icon: const Icon(Icons.comment),
                                  style: ButtonStyle(
                                    iconColor:
                                        MaterialStateProperty.all(Colors.blue),
                                    side: MaterialStateProperty.resolveWith<
                                        BorderSide>(
                                      (Set<MaterialState> states) {
                                        return const BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                        );
                                      },
                                    ),
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ]),
                        ])))
          ],
        ),
      ),
    );
  }
}
