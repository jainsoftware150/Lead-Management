import 'package:flutter/material.dart';
import 'package:projec1/crud.dart';
import 'package:intl/intl.dart';
import 'package:projec1/footer.dart';

import 'delete.dart';
// import 'flutter/ src/ painting/ text_style. dart';

class Dashboard extends StatefulWidget {
  final String userid;

  const Dashboard({super.key, required this.userid});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, String>> people = [
  ];

  String searchQuery = "";

  void addPerson(String name, String email, String phone) {
    setState(() {
      people.add({"name": name, "email": email, "phn": phone});
    });
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredPeople = people
        .where((person) =>
        person['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Leading",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Searchbar(onSearch: updateSearch, onAdd: addPerson),
            Expanded(child: CustomList(person: filteredPeople)),
            Footer()

          ],
        ),
      ),
    );
  }
}

class Searchbar extends StatelessWidget {
  final Function(String) onSearch;
  final Function(String, String, String) onAdd;

  const Searchbar({super.key, required this.onSearch, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final descriptionController =TextEditingController();


    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: onSearch,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add,color: Colors.black),
          onPressed: () {

            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    top: 16,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(labelText: 'Name'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: phoneController,
                          decoration: const InputDecoration(labelText: 'Phone'),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            CRUD().Creation(
                              nameController.text,
                              emailController.text,
                              phoneController.text,
                              descriptionController.text,


                            );
                            print("data added successfully");
                            onAdd(
                              nameController.text.trim(),
                              emailController.text.trim(),
                              phoneController.text.trim(),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text('Add Person'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );

          },
        ),
      ]),
    );
  }
}


class CustomList extends StatelessWidget {
  const CustomList({super.key, required List<Map<String, String>> person});

  @override
  Widget build(BuildContext context) {

    final descriptionController =TextEditingController();
    return StreamBuilder(
      stream: CRUD().Reading(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No data found'));
        }

        List docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> person = docs[index].data() as Map<String, dynamic>;
            TextEditingController myController = TextEditingController();

            return InkWell(
              onTap: () async {
                // Pick date
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                // Pick time
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                String resultDateTime = '';
                if (pickedDate != null && pickedTime != null) {
                  final combined = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                  resultDateTime = DateFormat('yyyy-MM-dd – kk:mm').format(combined);
                }

                // Show dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Enter Description'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: descriptionController,////////////////////////////////////////////
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (resultDateTime.isNotEmpty)
                            Text("Selected: $resultDateTime"),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            print("Text: ${myController.text}");
                            print("DateTime: $resultDateTime");
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${person['name'] ?? 'N/A'}"),
                        Text("Email: ${person['email'] ?? 'N/A'}"),
                        Text("Phone: ${person['phn'] ?? 'N/A'}"),
                      ],
                    ),
                    Delete(docId: docs[index].id),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

}
