import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageVideoPickerController extends GetxController {
  var base64Image = ''.obs;
  MediaFile? selectedMedia;

  Future<void> pickMedia() async {
    // Request permissions
    var status = await Permission.photos.request();
    if (status.isGranted) {
      try {
        final media = await GalleryPicker.pickMedia(
          context: Get.context!,
          singleMedia: true,
          config: Config(),
        );

        if (media != null && media.isNotEmpty) {
          selectedMedia = media.first;
          final bytes = File(selectedMedia!.file.toString()).readAsBytesSync();
          base64Image.value = base64Encode(bytes);
          update();
          print('Selected media: ${selectedMedia!.file}');
        } else {
          print('No media selected');
        }
      } catch (e) {
        print('Error picking media: $e');
      }
    } else {
      print('Permission not granted');
    }
  }
}

class NewImageVideoPickerDemo extends StatelessWidget {
  const NewImageVideoPickerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageVideoPickerController>(
      init: ImageVideoPickerController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Pick Image and Video from Gallery"),
            backgroundColor: Colors.deepPurple.shade100,
          ),
          body: Center(
            child: GestureDetector(
              onTap: controller.pickMedia,
              child: Obx(() => controller.base64Image.value.isEmpty
                  ? DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(16),
                color: Colors.black.withOpacity(0.16),
                strokeWidth: 2,
                dashPattern: const [3, 3, 3, 3],
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 56,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Click here to add image or video",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
                  : DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(16),
                color: Colors.black.withOpacity(0.16),
                strokeWidth: 2,
                dashPattern: const [3, 3, 3, 3],
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  child: controller.selectedMedia!.isImage
                      ? Image.memory(
                    base64Decode(controller.base64Image.value),
                    fit: BoxFit.cover,
                  )
                      : VideoPlayerWidget(controller.selectedMedia!.file.toString()),
                ),
              ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Example VideoPlayerWidget implementation (you need to have this implemented in your project):
class VideoPlayerWidget extends StatelessWidget {
  final String videoPath;

  const VideoPlayerWidget(this.videoPath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Add your VideoPlayer implementation here
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          'Video: $videoPath',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}