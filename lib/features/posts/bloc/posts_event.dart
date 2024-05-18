import 'package:flutter/material.dart';

@immutable
abstract class PostsEvent {}

class PostsInitialFetchEvent extends PostsEvent {}

class PostDetailsEvent extends PostsEvent {
  final int id;

  PostDetailsEvent({required this.id});
}

class PostAddEvent extends PostsEvent {
  final String title;
  final int userid;
  final String body;

  PostAddEvent({required this.title, required this.userid, required this.body});
}

class PostDeleteEvent extends PostsEvent {
  final int id;

  PostDeleteEvent({required this.id});
}
