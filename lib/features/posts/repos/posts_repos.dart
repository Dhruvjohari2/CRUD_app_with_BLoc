import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/post_data_ui_model.dart';
import '../models/post_details_data_ui_model.dart';

class PostsRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post = PostDataUiModel.fromMap(result[i] as Map<String, dynamic>);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      log('$e');
      return [];
    }
  }

  static Future<bool> addPosts(String title, int userid, String body) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        {"title": title, "body": body, "userId": userid}
      });
      debugPrint('response ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('$e');
      return false;
    }
  }

  static Future<bool> deletePosts(int id) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse('https://jsonplaceholder.typicode.com/posts?userId=$id'), body: {
        "method": 'DELETE',
      });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('$e');
      return false;
    }
  }

  static Future<List<PostDataDetailsUiModel>> fetchDetailsPosts(int id) async {
    var client = http.Client();
    List<PostDataDetailsUiModel> postsDetailsData = [];
    try {
      var response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1/comments'));
      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostDataDetailsUiModel postDetails = PostDataDetailsUiModel.fromMap(result[i] as Map<String, dynamic>);
        postsDetailsData.add(postDetails);
      }
      return postsDetailsData;
    } catch (e) {
      log('$e');
      return [];
    }
  }
}
