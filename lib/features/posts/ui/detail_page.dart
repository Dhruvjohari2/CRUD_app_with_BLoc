import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts_bloc.dart';
import '../bloc/posts_event.dart';
import '../bloc/posts_state.dart';
import 'add.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.id});

  final int id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final PostsBloc postsDetailBloc = PostsBloc();

  @override
  void initState() {
    postsDetailBloc.add(PostDetailsEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DetailPage ${widget.id}')),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: (){
      //    Navigator.push(context, MaterialPageRoute(builder: (_)=> const AddObject()));
      //   },
      // ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsDetailBloc,
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          debugPrint('state $state');
          switch (state.runtimeType) {
            case PostsFetchingLoadingDetailsState:
              return const Center(child: CircularProgressIndicator());
            case PostFetchingSuccessfulDetailsState:
              final successState = state as PostFetchingSuccessfulDetailsState;
              return ListView.builder(
                  itemCount: successState.postsDetails.length,
                  itemBuilder: (context, index) {
                    return Container(
                        color: Colors.grey[400],
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Column(children: [
                              Text('Id: ${successState.postsDetails[index].id}'),
                              Text('Id: ${successState.postsDetails[index].postId}'),
                            ]),
                            IconButton(
                                onPressed: () {
                                  postsDetailBloc.add(PostDeleteEvent(id: successState.postsDetails[index].postId));
                                },
                                icon: const Icon(Icons.delete)),
                          ]),
                          Text('Name: ${successState.postsDetails[index].name}'),
                          Text('Body: ${successState.postsDetails[index].body}'),
                          Text('Email: ${successState.postsDetails[index].email}'),
                        ]));
                  });
            case PostsFetchingErrorDetailsState:
              return const Center(child: Text('Something Went wrong '));
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
