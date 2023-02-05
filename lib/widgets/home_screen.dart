import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Todo: change to add screen and add normal home page
final formFields = [
  TextFieldWidget(text: 'Name'),
  TextFieldWidget(text: 'Surrname'),
  TextFieldWidget(text: 'Register Number', type: TextInputType.number),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  MyFormState createState() {
    return MyFormState();
  }
}

class MyFormState extends State<MyForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          for (var i = 0; i < formFields.length; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: formFields[i],
            ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({required this.text, this.type, super.key});

  final TextInputType? type;

  final String text;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextInputFormatter formater = FilteringTextInputFormatter.deny(r'\d');
    if (type == TextInputType.number) {
      formater = FilteringTextInputFormatter.digitsOnly;
    }
    return TextFormField(
      keyboardType: type,
      inputFormatters: [formater],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some data';
        }
        if (type != TextInputType.number) {
          RegExp regex = RegExp(r'^[A-ZŻŹĆĄŚĘŁÓŃ][a-zżźćńółęąś]+$');
          if (!regex.hasMatch(value)) {
            return 'Enter Correct Data';
          }
          return null;
        }
        if (text == 'Register Number' && value.length != 6) {
          return 'Enter Correct Data';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: text,
      ),
    );
  }
}
