import 'package:flutter/material.dart';
import 'package:projec1/crud.dart';

class Delete extends StatelessWidget {
  final String docId;

  const Delete({super.key, required this.docId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () async {
        try {
          await CRUD().Delete(docId);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Record deleted successfully"),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error deleting: $e"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }
}
