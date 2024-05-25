// employee_list_page.dart
import 'package:firebasefull/login.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'employee.dart';
import 'employee_detail_page.dart';
import 'profileview.dart';

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

  Future<void> _refreshEmployees() async {
    setState(() {
      futureEmployees = ApiService().fetchEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: Icon(Icons.account_circle),
          ),
          TextButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmailAndPasswordSignIn()),
            );
          }, child: Text('Logout'))
        ],
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
                return Container(decoration: BoxDecoration(color: Colors.grey),
                  child: ListTile(
                    title: Text(employee.employeeName),
                    leading: employee.profileImage.isNotEmpty
                        ? CircleAvatar(
                      backgroundImage: NetworkImage(employee.profileImage),
                    )
                        : CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeeDetailPage(employee: employee),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshEmployees,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
