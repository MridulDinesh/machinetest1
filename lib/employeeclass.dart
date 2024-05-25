// employee_list_page.dart
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'employee.dart';

class EmployeeListPage extends StatefulWidget {
  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  late Future<List<Employee>> futureEmployees;

  @override
  void initState() {
    super.initState();
    futureEmployees = ApiService().fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
      ),
      body: FutureBuilder<List<Employee>>(
        future: futureEmployees,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Employees Found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final employee = snapshot.data![index];
                return ListTile(
                  title: Text(employee.employeeName),
                  subtitle: Text('Age: ${employee.employeeAge}, Salary: ${employee.employeeSalary}'),
                  leading: employee.profileImage.isNotEmpty
                      ? CircleAvatar(
                    backgroundImage: NetworkImage(employee.profileImage),
                  )
                      : CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
