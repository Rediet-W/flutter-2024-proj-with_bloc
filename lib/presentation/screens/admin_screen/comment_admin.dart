import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminCommentPage extends StatefulWidget {
  @override
  _AdminCommentPageState createState() => _AdminCommentPageState();
}

class _AdminCommentPageState extends State<AdminCommentPage> {
  List<Map<String, String>> filedata = [
    {
      'name': 'Nahusenay',
      'message':
          "Thank you for posting! I lost my keys near the park yesterday. Could you please describe any unique features of the key? I can confirm if it's mine.",
    },
    {
      'name': 'Liya Abebe',
      'message': 'Very cool',
    },
    {
      'name': 'Abel Daniel',
      'message': 'Do the keys have ',
    },
    {
      'name': 'Dagmawi Elias',
      'message': 'Your phone is not working how can I contact you',
    },
  ];

  Widget commentChild(List<Map<String, String>> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
          child: ListTile(
            title: Row(
              children: [
                Text(
                  data[index]['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      filedata.removeAt(index);
                    });
                  },
                ),
              ],
            ),
            subtitle: Text(data[index]['message']!),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
            child: const Text(
              'comments',
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
      body: Column(
        children: [
          Expanded(
            child: commentChild(filedata),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCommentField(
              labelText: 'Add a comment...',
              errorText: 'no comment added',
              sendButtonMethod: (commentText) {
                setState(() {
                  var value = {
                    'name': 'Unknown',
                    'message': commentText,
                  };
                  filedata.insert(0, value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCommentField extends StatefulWidget {
  final String labelText;
  final String errorText;
  final Function(String) sendButtonMethod;

  const CustomCommentField({
    required this.labelText,
    required this.errorText,
    required this.sendButtonMethod,
  });

  @override
  _CustomCommentFieldState createState() => _CustomCommentFieldState();
}

class _CustomCommentFieldState extends State<CustomCommentField> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: commentController,
            decoration: InputDecoration(
              labelText: widget.labelText,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send,
              color: Colors.blue), // Set icon color to blue
          onPressed: () {
            if (commentController.text.trim().isNotEmpty) {
              widget.sendButtonMethod(commentController.text);
              commentController.clear();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(widget.errorText),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}
