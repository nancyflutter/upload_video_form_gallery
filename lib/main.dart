import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upload_video_form_gallery/screens/multiple_image_video_picker.dart';
// import 'package:upload_video_form_gallery/screens/new_screen.dart';
// import 'package:upload_video_form_gallery/screens/only_video_picker.dart';
// import 'package:upload_video_form_gallery/screens/single_collection_pick_image_video.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Media Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MediaPickerScreen(),  // ONLY VIDEO PICK AND UPLOAD
      home: const MyHomePage(title: "Gallery Picker"), // pick image and video both from gallery and upload both on page-view
      // home: const ImageVideoPickerDemo(),  // try to pick image video single time but not working
      // home: const NewImageVideoPickerDemo(),
    );
  }
}
