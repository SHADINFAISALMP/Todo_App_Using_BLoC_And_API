import "package:http/http.dart" as http;

class Tododataprovider {
  Future<http.Response> fetchtodo() async {
    const url = "https://api.nstack.in/v1/todos?page=1&limit=20";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    return response;
  }

  Map<String, String> dataProviderSubmitData(String title, String description) {
    final body = {"title": title, "description": description};
    return body;
  }

  Future<http.Response> deletebyid(String id) async {
    try {
      final url = 'https://api.nstack.in/v1/todos/$id';
      final uri = Uri.parse(url);

      final response = await http.delete(uri);
      return response;
    } catch (e) {
      return http.Response('error deleting data:$e', 500);
    }
  }

  Map<String, String> dataProviderEditData(String title, String description) {
    final body = {"title": title, "description": description};
    return body;
  }
}
