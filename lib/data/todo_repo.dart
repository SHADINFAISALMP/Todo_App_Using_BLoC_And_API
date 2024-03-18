import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_bloc/data/todo_data_provider.dart';

class Repository {
  Future<List<dynamic>> getdata() async {
    try {
      final response = await Tododataprovider().fetchtodo();
      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        return json['items'];
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  submitdata(String title, String description) async {
    final body = Tododataprovider().dataProviderSubmitData(title, description);
    //submit data to server
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    try {
      final response = await http.post(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 201) {
        return "success";
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  deletedata(String id) async {
    try {
      final response = await Tododataprovider().deletebyid(id);
      if (response.statusCode == 200) {
        return "success";
      }
    } catch (e) {
      return "failure";
    }
  }

  updatedata(String id, String title, String description) async {
    try {
      final body = Tododataprovider().dataProviderEditData(title, description);
      final url = 'https://api.nstack.in/v1/todos/$id';
      final uri = Uri.parse(url);
      
      final response = await http.put(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      
      if (response.statusCode == 200) {
       
        return "success";
      } else {
      
      }
    } catch (e) {
      
      return "failure";
    }
  }
}
