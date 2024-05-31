import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/post/bloc/post_bloc.dart';
import 'package:flutter_project/post/bloc/post_state.dart';
import 'package:flutter_project/post/bloc/post_event.dart';
import 'package:flutter_project/post/repository/post_repository.dart';
import 'package:go_router/go_router.dart';

class ItemPage extends StatelessWidget {
  final String postId;

  ItemPage({required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(
        postRepository: context.read<PostRepository>(),
      )..add(LoadPost(postId)),
      child: Scaffold(
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
                  letterSpacing: 1.3,
                ),
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
              iconColor: MaterialStatePropertyAll(Colors.white),
            ),
          ),
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoadingDetails) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PostDetailsLoaded) {
              final postDetails = state.postDetails;

              return Center(
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
                      ),
                    ),
                    Positioned(
                      top: 380,
                      left: 45,
                      child: Container(
                        width: 330,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Center(
                              child: Text(
                                postDetails.description ?? 'Item name',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Found on ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 238, 238, 238),
                                        ),
                                      ),
                                      Text(
                                        postDetails.description ?? 'N/A',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Color.fromARGB(
                                              255, 238, 238, 238),
                                        ),
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
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Location ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        postDetails.location ?? 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              child: Text(
                                postDetails.description ?? 'N/A',
                                style: const TextStyle(
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.go('/comment', extra: postDetails.id);
                              },
                              icon: const Icon(Icons.comment),
                              style: ButtonStyle(
                                iconColor:
                                    MaterialStatePropertyAll(Colors.blue),
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is PostLoadingDetailsError) {
              return Center(child: Text(state.error));
            } else {
              return Center(child: Text('No post details found'));
            }
          },
        ),
      ),
    );
  }
}
