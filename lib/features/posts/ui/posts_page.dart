import 'package:crud_bloc/features/posts/ui/add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts_event.dart';
import 'detail_page.dart';
import '../bloc/posts_bloc.dart';
import '../bloc/posts_state.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostsBloc postsBloc = PostsBloc();
  String title = "";
  String body = "";
  String userID = "";

  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PostPage')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showMyDialog();
        },
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          debugPrint('state $state');
          switch (state.runtimeType) {
            case PostsFetchingLoadingState:
              return const Center(child: CircularProgressIndicator());
            case PostFetchingSuccessfulState:
              final successState = state as PostFetchingSuccessfulState;
              return ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                            color: Colors.grey[400],
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Id: ${successState.posts[index].id}'),
                                  Text(
                                      'Title: ${successState.posts[index].title}'),
                                  Text(
                                      'Body: ${successState.posts[index].body}'),
                                ])),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DetailPage(
                                              id: successState
                                                  .posts[index].id)));
                                },
                                child: const Text('Next Page')),
                            const SizedBox(width: 20),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AddObject()));
                                }, child: Text('Edit '))
                          ],
                        )
                      ],
                    );
                  });
            case PostsFetchingErrorState:
              return Center(child: Text('Something Went wrong '));
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    initialValue: title,
                    onChanged: (value) => title = value.trim(),
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter title",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    initialValue: body,
                    onChanged: (value) => body = value.trim(),
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Body",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: userID,
                    onChanged: (value) => userID = value.trim(),
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Userid",
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                postsBloc.add(PostAddEvent(
                    body: body, title: title, userid: int.parse(userID)));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
