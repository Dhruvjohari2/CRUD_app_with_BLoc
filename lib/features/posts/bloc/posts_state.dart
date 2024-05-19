import 'package:flutter/material.dart';

import '../models/post_data_ui_model.dart';
import '../models/post_details_data_ui_model.dart';

@immutable
abstract class PostsState {}

abstract class PostsActionState extends PostsState {}

class PostsInitial extends PostsState {}

class PostsFetchingLoadingState extends PostsState {}

class PostsFetchingErrorState extends PostsState {}

class PostFetchingSuccessfulState extends PostsState {
  final List<PostDataUiModel> posts;
  PostFetchingSuccessfulState({
    required this.posts,
  });
}

// Add details page

class PostsAdditionLoadingState extends PostsState {}

class PostsAdditionSuccessState extends PostsState {}

class PostsAdditionErrorState extends PostsState {}

// Details Page

class PostsFetchingLoadingDetailsState extends PostsState {}

class PostFetchingSuccessfulDetailsState extends PostsState {
  final List<PostDataDetailsUiModel> postsDetails;
  PostFetchingSuccessfulDetailsState({
    required this.postsDetails,
  });
}
class PostsFetchingErrorDetailsState extends PostsState {}


//Delete Event


class PostsDeleteIdState extends PostsState {}

class PostsDeleteErrorState extends PostsState {}

// update Objects

class PostsUpdateLoadingState extends PostsState {}

class PostsUpdateSuccessState extends PostsState {}

class PostsUpdateErrorState extends PostsState {}


