import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Todowithoutmodel extends StatefulWidget {
  const Todowithoutmodel({super.key});

  @override
  State<Todowithoutmodel> createState() => _TodoState();
}

class _TodoState extends State<Todowithoutmodel> {
  List<dynamic> user = [];
  Map<String, dynamic> postdata = {};
  Map<String, dynamic> updatedata = {};

  TextEditingController add = TextEditingController();
  TextEditingController update = TextEditingController();

  void _showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showupdateDialog(BuildContext context, int index) {
    update.text = user[index]['name'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update Task"),
          content: TextField(
            controller: update,
            decoration: const InputDecoration(hintText: "Enter task name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                updatedata = {"name": update.text};
                updateData(user[index]['_id'], index, updatedata);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getunicorndata() async {
    var response = await http.get(Uri.parse(
        ("https://crudcrud.com/api/866b11cfa09a49bc83c7880d0582873f/unicorns")));
    if (response.statusCode == 200) {
      user = jsonDecode(response.body);
      setState(() {});
    } else {
      _showAlertDialog(context, "Error", "Failed to fetch data");
    }
  }

  Future<void> postData(Map<String, dynamic> data) async {
    var response = await http.post(
      Uri.parse(
          'https://crudcrud.com/api/866b11cfa09a49bc83c7880d0582873f/unicorns'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      await getunicorndata();
      add.clear();
    } else {
      _showAlertDialog(context, "Error", "Failed to add task");
    }
  }

  Future<void> updateData(
      String id, int index, Map<String, dynamic> userdata) async {
    var response = await http.put(
      Uri.parse(
          'https://crudcrud.com/api/866b11cfa09a49bc83c7880d0582873f/unicorns/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userdata), // Use the userdata here
    );
    if (response.statusCode == 200) {
      await getunicorndata();
      setState(() {});
    } else {
      _showAlertDialog(context, "Error", "Failed to update task");
    }
  }

  Future<void> deleteData(String id, int index) async {
    var response = await http.delete(Uri.parse(
        'https://crudcrud.com/api/866b11cfa09a49bc83c7880d0582873f/unicorns/$id'));
    if (response.statusCode == 200) {
      user.removeAt(index);
      setState(() {});
    } else {
      _showAlertDialog(context, "Error", "Failed to delete task");
    }
  }

  @override
  void initState() {
    super.initState();
    getunicorndata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Center(
          child: Text("Todo App"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: add,
              decoration: const InputDecoration(
                labelText: "Enter Task",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                prefixIcon: Icon(Icons.task),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: user.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: user.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            tileColor: Colors.white,
                            title: Text(user[index]['name']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _showupdateDialog(context, index);
                                  },
                                  icon: const Icon(Icons.update),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteData(user[index]['_id'], index);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          if (add.text.isEmpty) {
            _showAlertDialog(context, "Error", "Please enter a value!!!");
          } else {
            postdata = {
              "name": add.text,
            };
            postData(postdata);
          }
        },
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}