// create_post_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/post/bloc/post_bloc.dart';
import 'package:flutter_project/post/bloc/post_state.dart';

class CreatePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Post created successfully!')),
            );
          } else if (state is PostFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to create post')),
            );
          }
        },
        builder: (context, state) {
          if (state is PostLoading) {
            return Center(child: CircularProgressIndicator());
          }
          // Your form or other UI components here
          return Container();
        },
      ),
    );
  }
}
