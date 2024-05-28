import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/comment_bloc.dart';
import '../bloc/comment_event.dart';
import '../bloc/comment_state.dart';
import '../repository/comment_repository.dart';

class CommentPage extends StatelessWidget {
  final String postId;

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
                    return Center(child: CircularProgressIndicator());
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
                    return Center(child: Text(state.message));
                  } else {
                    return Center(child: Text('No comments found'));
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
                      onSubmitted: (comment) {
                        if (comment.isNotEmpty) {
                          context.read<CommentBloc>().add(AddComment(
                                postId: postId,
                                userId:
                                    'currentUserId', // Replace with actual user ID
                                content: comment,
                              ));
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      final comment = (context as Element)
                          .findAncestorWidgetOfExactType<TextField>()
                          ?.controller
                          ?.text;
                      if (comment != null && comment.isNotEmpty) {
                        context.read<CommentBloc>().add(AddComment(
                              postId: postId,
                              userId:
                                  'currentUserId', // Replace with actual user ID
                              content: comment,
                            ));
                        // Clear the text field
                        (context as Element)
                            .findAncestorWidgetOfExactType<TextField>()
                            ?.controller
                            ?.clear();
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
