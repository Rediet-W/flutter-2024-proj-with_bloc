import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_project/post/bloc/post_bloc.dart';
import 'package:flutter_project/post/bloc/post_event.dart';
import 'package:flutter_project/post/bloc/post_state.dart';
import 'package:flutter_project/post/repository/post_repository.dart';
import 'package:flutter_project/post/model/post.dart';
import '../../secure_storage_service.dart';

class WithAccount extends StatelessWidget {
  final SecureStorageService _secureStorageService = SecureStorageService();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(
        postRepository: PostRepository(baseUrl: 'http://localhost:3003/'),
      )..add(LoadPost('')), // Ensure LoadPost event is correct
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          actions: [
            TextButton(
              onPressed: () async {
                await _secureStorageService.deleteTokenRolesAndUserId();
                context.go('/login');
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 17),
                child: Text(
                  'Log out',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    letterSpacing: 1.3,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PostLoadingDetailsError) {
              return Center(
                  child: Text('Failed to load posts: ${state.error}'));
            } else if (state is PostLoaded) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 33,
                  children: List.generate(state.posts.length, (index) {
                    final post = state.posts[index];
                    return GridItem(
                      post: post,
                      navigateToComment: (postId) {
                        context.go('/comment?postId=$postId');
                      },
                    );
                  }),
                ),
              );
            } else if (state is PostLoading ||
                state is PostLoadingDetailsError) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Scaffold(
                body: Center(
                  child: Text('Failed to load posts'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final Post post;
  final Function(String? postId) navigateToComment;

  GridItem({required this.post, required this.navigateToComment});

  @override
  Widget build(BuildContext context) {
    Uint8List? imageData = post.pictureBuffer != null
        ? Uint8List.fromList(post.pictureBuffer!)
        : null;

    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 7),
          Expanded(
            child: imageData != null
                ? Image.memory(
                    imageData,
                    fit: BoxFit.contain,
                  )
                : Container(
                    color: Colors.grey, // Placeholder or default image
                    child: Center(
                      child: Text('No Image'),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  context.go('/details'); // Changed from '/login'
                },
                icon: Icon(Icons.read_more), // Changed from Icons.more_vert
                color: Colors.blue,
              ),
              IconButton(
                onPressed: () {
                  navigateToComment(
                      post.id); // Pass postId to navigateToComment
                },
                icon: Icon(Icons.comment), // Changed from Icons.comment_rounded
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
