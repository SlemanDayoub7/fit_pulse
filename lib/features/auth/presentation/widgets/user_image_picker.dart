// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class UserImagePicker extends StatefulWidget {
//   final String? existingImagePath; // Pass existing image file path if available

//   const UserImagePicker({Key? key, this.existingImagePath}) : super(key: key);

//   @override
//   State<UserImagePicker> createState() => _UserImagePickerState();
// }

// class _UserImagePickerState extends State<UserImagePicker> {
//   File? _imageFile;
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.existingImagePath != null) {
//       _imageFile = File(widget.existingImagePath!);
//     }
//   }

//   Future<void> _pickImage() async {
//     final XFile? pickedImage =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _imageFile = File(pickedImage.path);
//       });
//       // Optionally save this file path to persistent storage here for future reuse
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _pickImage,
//       child: CircleAvatar(
//         radius: 60,
//         backgroundColor: Colors.grey[300],
//         backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
//         child: _imageFile == null
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Icon(Icons.camera_alt, size: 40, color: Colors.white70),
//                   SizedBox(height: 4),
//                   Text("Select Image", style: TextStyle(color: Colors.white70)),
//                 ],
//               )
//             : null,
//       ),
//     );
//   }
// }
