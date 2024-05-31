import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/comment_bloc.dart';
import '../bloc/comment_event.dart';
import '../bloc/comment_state.dart';
import '../repository/comment_repository.dart';
import '../../secure_storage_service.dart'; // Import SecureStorageService
import 'package:mongo_dart/mongo_dart.dart';

class CommentPage extends StatelessWidget {
  final ObjectId postId;

  CommentPage({required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CommentBloc(commentRepository: context.read<CommentRepository>())
            ..add(LoadComments(postId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Comments'),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CommentBloc, CommentState>(
                builder: (context, state) {
                  if (state is CommentsLoading) {
                    return Container(child: CircularProgressIndicator());
                  } else if (state is CommentsLoaded) {
                    return ListView.builder(
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.comments[index].content),
                        );
                      },
                    );
                  } else if (state is CommentError) {
                    return Container(child: Text(state.message));
                  } else {
                    return Container(child: Text('No comments found'));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Add a comment...',
                      ),
                      onSubmitted: (comment) async {
                        if (comment.isNotEmpty) {
                          final userId =
                              await SecureStorageService().readUserId();
                          context.read<CommentBloc>().add(AddComment(
                                postId: postId,
                                userId: userId,
                                content: comment,
                              ));
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      final commentController = (context as Element)
                          .findAncestorWidgetOfExactType<TextField>()
                          ?.controller;
                      final comment = commentController?.text;
                      if (comment != null && comment.isNotEmpty) {
                        final userId =
                            await SecureStorageService().readUserId();
                        context.read<CommentBloc>().add(AddComment(
                              postId: postId,
                              userId: userId,
                              content: comment,
                            ));
                        // Clear the text field
                        commentController?.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
