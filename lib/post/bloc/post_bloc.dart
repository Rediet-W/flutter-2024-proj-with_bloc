import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/post_repository.dart';
import '../model/post.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<CreatePost>(_onCreatePost);
    on<LoadPost>(_onLoadPost);
    on<DeletePost>(_onDeletePost);
    on<EditPost>(_onEditPost);
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

  void _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      await postRepository.deletePost(event.postId);
      emit(PostDeleted());
      add(LoadPost(''));
    } catch (e) {
      emit(PostError('Failed to delete post'));
    }
  }

  void _onEditPost(EditPost event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      await postRepository.editPost(event.postId, event.content);
      emit(PostEdited());
      add(LoadPost(''));
    } catch (e) {
      emit(PostError('Failed to edit post'));
    }
  }
}
