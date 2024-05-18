import 'dart:async';
import 'package:bloc/bloc.dart';

import '../models/post_data_ui_model.dart';
import '../models/post_details_data_ui_model.dart';
import '../repos/posts_repos.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostDetailsEvent>(postsDetailsFetchEvent);
    on<PostAddEvent>(postAddEvent);
    on<PostDeleteEvent>(postDeleteEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());

    List<PostDataUiModel> posts = await PostsRepo.fetchPosts();
    emit(PostFetchingSuccessfulState(posts: posts));
  }

  FutureOr<void> postsDetailsFetchEvent(
      PostDetailsEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingDetailsState());

    List<PostDataDetailsUiModel> postsDetails =
        await PostsRepo.fetchDetailsPosts(event.id);
    emit(PostFetchingSuccessfulDetailsState(postsDetails: postsDetails));
  }

  FutureOr<void> postDeleteEvent(
      PostDeleteEvent event, Emitter<PostsState> emit) async {
    bool success = await PostsRepo.deletePosts(event.id);
    print(success);
    if (success) {
      emit(PostsDeleteIdState());
    } else {
      emit(PostsDeleteErrorState());
    }
  }

  FutureOr<void> postAddEvent(
      PostAddEvent event, Emitter<PostsState> emit) async {
    bool success = await PostsRepo.addPosts(event.title, event.userid, event.body);
    print(success);
    if (success) {
      emit(PostsAdditionSuccessState());
    } else {
      emit(PostsAdditionErrorState());
    }
  }
}
