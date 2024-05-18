import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts_bloc.dart';
import '../bloc/posts_event.dart';
import '../bloc/posts_state.dart';

class AddObject extends StatefulWidget {
  const AddObject({super.key});

  @override
  State<AddObject> createState() => _AddObjectState();
}

class _AddObjectState extends State<AddObject> {
  String? name;
  int year = 0;
  int price = 0;
  String? model;
  String? disk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
      BlocConsumer<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state is PostsAdditionSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post added successfully!')));
          }
        },
        builder: (context, state) {
          if (state is PostsAdditionLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PostsAdditionErrorState) {
            return const Center(child: Text('Something Went Wrong!'));
          } else {
            return buildInitialLayout(context);
          }
        },
      ),
    );
  }

  Widget buildInitialLayout(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              initialValue: name,
              onChanged: (value) => name = value.trim(),
              style: const TextStyle(fontSize: 12, color: Colors.black),
              decoration: const InputDecoration(
                icon: Icon(Icons.code, size: 20),
                border: InputBorder.none,
                hintText: "Enter Name",
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: year.toString(),
              onChanged: (value) => year = int.tryParse(value.trim()) ?? 0,
              style: const TextStyle(fontSize: 12, color: Colors.black),
              decoration: const InputDecoration(
                icon: Icon(Icons.code, size: 20),
                border: InputBorder.none,
                hintText: "Enter Year",
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: price.toString(),
              onChanged: (value) => price = int.tryParse(value.trim()) ?? 0,
              style: const TextStyle(fontSize: 12, color: Colors.black),
              decoration: const InputDecoration(
                icon: Icon(Icons.code, size: 20),
                border: InputBorder.none,
                hintText: "Enter Price",
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              initialValue: model,
              onChanged: (value) => model = value.trim(),
              style: const TextStyle(fontSize: 12, color: Colors.black),
              decoration: const InputDecoration(
                icon: Icon(Icons.code, size: 20),
                border: InputBorder.none,
                hintText: "Enter Model",
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              initialValue: disk,
              onChanged: (value) => disk = value.trim(),
              style: const TextStyle(fontSize: 12, color: Colors.black),
              decoration: const InputDecoration(
                icon: Icon(Icons.code, size: 20),
                border: InputBorder.none,
                hintText: "Enter Disk",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // final post = Post(
                //   name: name,
                //   year: year,
                //   price: price,
                //   model: model,
                //   disk: disk,
                // );
                //   context.read<PostsBloc>().add(PostAddEvent( name: name!,
                //     year: year,
                //     price: price,
                //     model: model!,
                //     disk: disk!,));
              },
              child: const Text('SUBMIT'),
            )
          ],
        ),
      );
}
