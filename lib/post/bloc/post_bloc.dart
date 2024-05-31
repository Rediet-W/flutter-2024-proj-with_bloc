import 'package:flutter_bloc/flutter_bloc.dart';
import 'post_event.dart';
import 'post_state.dart';
import '../repository/post_repository.dart';
import '../model/post.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<CreatePost>(_onCreatePost);
    on<LoadPost>(_onLoadPost);
  }

  void _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      await postRepository.createPost(
        category: event.category,
        description: event.description,
        location: event.location,
        time: event.time,
        pictureBuffer: event.pictureBuffer,
      );
      emit(PostSuccess());
    } catch (e) {
      emit(PostFailure(error: e.toString()));
    }
  }

  void _onLoadPost(LoadPost event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final List<Post> posts = await postRepository.fetchPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostLoadingDetailsError(error: e.toString()));
    }
  }
}
