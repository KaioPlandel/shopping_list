import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>(); //Add global key

  _saveItem() {
    _formKey.currentState!.validate(); //use to validate form
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new item"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          // add all the body of the project in Form widget
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                //Use Forms widgets to validate
                maxLength: 50,
                decoration: const InputDecoration(label: Text("Name")),
                validator: (value) {
                  // user validator and put the logic between
                  if (value == null ||
                      value.isNotEmpty ||
                      value.trim().length <= 1 ||
                      value.length > 50) {
                    return "Must be between 1 and 50 characters.";
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(label: Text("Quantity")),
                      initialValue: "1",
                      validator: (value) {
                        if (value == null ||
                            value.isNotEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return "Must be a valid, positive number.";
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(items: [
                      // other type of Form widget
                      for (final category in categories.entries)
                        DropdownMenuItem(
                          value: category.value,
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: category.value.color,
                              ),
                              const SizedBox(width: 6),
                              Text(category.value.title)
                            ],
                          ),
                        )
                    ], onChanged: (value) {}),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset(); // limpa os campos
                      },
                      child: const Text("Reset")),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: const Text("Add Item"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
