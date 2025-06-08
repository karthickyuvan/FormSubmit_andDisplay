// Step 1: Flutter basics import
import 'package:flutter/material.dart';

// Step 2: main() function - app entry point
void main() {
  runApp(const MyApp());
}

// Step 3: StatelessWidget for app structure
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact Form',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ContactFormPage(),
    );
  }
}
// Step 4: ContactFormPage create panrom

class ContactFormPage extends StatefulWidget {
  const ContactFormPage({super.key});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

// Step 5: State create panrom
class _ContactFormPageState extends State<ContactFormPage> {
  // Text controllers for name, email, message
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  //validation for textfields
  final _formkey=GlobalKey<FormState>();
  // Dispose controllers
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
  // UI design

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: Form (
          key: _formkey,
          child: Column(
            children: [
              //Name TextFileld
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value){if(value==null|| value.trim().isEmpty){
                  return 'Please enter your name';
                }
                }
              ),
              const SizedBox(height: 16),
              // Email TextField
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),   
                validator:(value){
                    if(value==null || value.trim().isEmpty){
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                    return 'Enter a valid email address';
                  }
                  return null;
                  }
              ),
              const SizedBox(height: 16),
              // Message TextField
              TextFormField(
                controller: messageController,
                decoration: const InputDecoration(
                  labelText: 'Enter Your Message',
                  border: OutlineInputBorder(),
                ),
                validator:(value){
                  if(value==null || value.trim().isEmpty){
                    return'Please Enter Your Message';
                  }
                },
              ),
              const SizedBox(height: 16),
              // Submit Button
              ElevatedButton(
                onPressed: () {
                 
                  //get data from fields
                  final name = nameController.text;
                  final email = emailController.text;
                  final message = messageController.text;
                   // Validation logic
                  if(_formkey.currentState!.validate()){
                  //Alert dialog with entered details
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Submitted Details'),
                      content: Text('Name:$name\nEmail:$email\nMessage:$message'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                  nameController.clear();
          emailController.clear();
          messageController.clear();
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
