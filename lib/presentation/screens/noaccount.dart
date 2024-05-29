import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../post/bloc/post_bloc.dart';
import '../../../post/bloc/post_event.dart';
import '../../../post/bloc/post_state.dart';
import '../../../post/repository/post_repository.dart';
import '../../post/model/post.dart';

class NoAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(
          postRepository: PostRepository(baseUrl: 'http://localhost:3003/'))
        ..add(LoadPost('')), // Ensure LoadPost event is correct
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          actions: [
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
                  child: Text('Failed to load items: ${state.error}'));
            } else if (state is PostLoaded) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 33,
                  children: List.generate(state.posts.length, (index) {
                    return GridItem(
                      post: state.posts[index],
                    );
                  }),
                ),
              );
            }
            return Container(); // Default case
          },
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final Post post;

  GridItem({required this.post});

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
              post.imageUrl,
              fit: BoxFit.contain,
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
                  context.go('/login');
                },
                icon: Icon(Icons.read_more),
                color: Colors.blue,
              ),
              IconButton(
                onPressed: () {
                  context.go('/login');
                },
                icon: Icon(Icons.comment),
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
