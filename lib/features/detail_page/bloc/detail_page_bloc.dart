// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'detail_page_event.dart';
// import 'detail_page_state.dart';
//
// class ApiBloc extends Bloc<ApiEvent, ApiState> {
//   ApiBloc() : super(ApiInitial());
//
//   @override
//   Stream<ApiState> mapEventToState(ApiEvent event) async* {
//     if (event is FetchData) {
//       yield ApiLoading();
//       try {
//         final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/${event.id}/comments'));
//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);
//           yield ApiLoaded(data);
//         } else {
//           yield ApiError('Failed to load data');
//         }
//       } catch (e) {
//         yield ApiError('Failed to load data');
//       }
//     }
//   }
// }
