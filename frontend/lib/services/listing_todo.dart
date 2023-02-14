// import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:frontend/models/todo_models.dart';
import 'package:get/get.dart';

class ListingTodo extends GetxController {
  var isLoading = false.obs;
  var todoModel = <TodoModel>[].obs;

  getDataFromAPI() async {
    isLoading.value = true;
    try {
      var response = await Dio().get('http://10.0.2.2:8000/');
      isLoading.value = false;
      todoModel.addAll(todoModelFromJson(response.data));
    } catch (e) {
      print(e);
    }
  }
}
