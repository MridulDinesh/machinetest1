import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Update extends StatefulWidget {
  final String documentId;
  final String email;
  final String address;
  final String phone;
  final String Fname;

  const Update({
    Key? key,
    required this.documentId,
    required this.email,
    required this.address,
    required this.phone,
    required this.Fname,

  }) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _FnameController;


  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.address);
    _phoneController = TextEditingController(text: widget.phone);
    _FnameController = TextEditingController(text: widget.Fname);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User Info'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${widget.email}'),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: _FnameController,
              decoration: InputDecoration(labelText: 'fname'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Update user info in Firestore
                FirebaseFirestore.instance.collection('users').doc(widget.documentId).update({
                  'address': _addressController.text,
                  'phone': _phoneController.text,
                  'Fname': _FnameController.text,

                }).then((value) {
                  // Navigate back to previous page
                  Navigator.pop(context);
                }).catchError((error) {
                  print("Failed to update user info: $error");
                  // Handle error
                });
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}