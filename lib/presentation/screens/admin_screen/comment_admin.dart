import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../comment/bloc/comment_bloc.dart';
import '../../../comment/repository/comment_repository.dart';
import '../../../comment/bloc/comment_state.dart';
import '../../../comment/bloc/comment_event.dart';
import '../../../secure_storage_service.dart'; // Import SecureStorageService
import 'package:mongo_dart/mongo_dart.dart';

class AdminCommentPage extends StatelessWidget {
  final String? postId;

  AdminCommentPage({this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentBloc(
        commentRepository: context.read<CommentRepository>(),
      )..add(LoadComments()),
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
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
// Show dialog to edit comment
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      TextEditingController _controller =
                                          TextEditingController(
                                        text: state.comments[index].content,
                                      );
                                      return AlertDialog(
                                        title: Text('Edit Comment'),
                                        content: TextField(
                                          controller: _controller,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              context
                                                  .read<CommentBloc>()
                                                  .add(EditComment(
                                                    commentId: state
                                                        .comments[index].id,
                                                    content: _controller.text,
                                                  ));
                                              Navigator.pop(context);
                                            },
                                            child: Text('Save'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  context.read<CommentBloc>().add(DeleteComment(
                                        commentId: state.comments[index].id,
                                      ));
                                },
                              ),
                            ],
                          ),
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
