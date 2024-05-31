import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class LostFoundForm extends StatefulWidget {
  @override
  _LostFoundFormState createState() => _LostFoundFormState();
}

class _LostFoundFormState extends State<LostFoundForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _selectedImage;

  Future<void> _postItem(Uint8List? imageData) async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _timeController.text.isEmpty ||
        imageData == null ||
        imageData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please fill in all fields and attach an image.')));
      return;
    }

    try {
      var uri = Uri.parse('http://localhost:3003/items');
      var request = http.MultipartRequest('POST', uri)
        ..fields['description'] = _descriptionController.text
        ..files.add(http.MultipartFile.fromBytes(
          'picture', // Ensure this field matches the name expected by your NestJS backend
          imageData,
          filename:
              'upload.jpg', // Optional, you can provide filename based on your requirement
        ));
      var response = await request.send();
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Post created successfully.')));
        _titleController.clear();
        _locationController.clear();
        _timeController.clear();
        _descriptionController.clear();
        setState(() {
          _selectedImage = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to create post: ${response.reasonPhrase}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to create post: $e')));
    }
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final pickedImageData = await pickedImage.readAsBytes();
      setState(() {
        _selectedImage = pickedImageData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.attach_file),
              label: Text('Attach Image'),
            ),
            SizedBox(height: 16),
            if (_selectedImage != null)
              Image.memory(
                _selectedImage!,
                height: 200,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _postItem(_selectedImage),
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
