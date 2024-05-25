// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'employee.dart';

class ApiService {
  static const String apiUrl = 'https://dummy.restapiexample.com/api/v1/employees';

  Future<List<Employee>> fetchEmployees() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['data'];
      List<Employee> employees = body.map((dynamic item) => Employee.fromJson(item)).toList();
      return employees;
    } else {
      throw Exception('Failed to load employees');
    }
  }
}
