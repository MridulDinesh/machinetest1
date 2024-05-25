// employee_detail_page.dart
import 'package:flutter/material.dart';
import 'employee.dart';

class EmployeeDetailPage extends StatelessWidget {
  final Employee employee;

  EmployeeDetailPage({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(employee.employeeName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${employee.employeeName}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Age: ${employee.employeeAge}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Salary: ${employee.employeeSalary}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
