// Single IMAGE OR VIDEO ARE PICKED AND UPLOADED...

import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class ImageVideoPickerDemo extends StatefulWidget {
  const ImageVideoPickerDemo({super.key});

  @override
  State<ImageVideoPickerDemo> createState() => _ImageVideoPickerDemoState();
}

class _ImageVideoPickerDemoState extends State<ImageVideoPickerDemo> {
  MediaFile? selectedMedia;

  Future<void> _pickMedia() async {
    final media = await GalleryPicker.pickMedia(
      context: context,
      singleMedia: true,
      config: Config(),
    );

    if (media != null && media.isNotEmpty) {
      setState(() {
        selectedMedia = media.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick image and video from gallery"),
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: Center(
        child: GestureDetector(
          onTap: _pickMedia,
          child: selectedMedia == null
              ? DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(16),
                  color: Colors.black.withOpacity(0.16),
                  strokeWidth: 2,
                  dashPattern: const [3, 3, 3, 3],
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: const Padding(
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
                  radius: const Radius.circular(16),
                  color: Colors.black.withOpacity(0.16),
                  strokeWidth: 2,
                  dashPattern: const [3, 3, 3, 3],
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: SizedBox(
                      height: 400,
                      // width: 250,
                      child: MediaProvider(
                        media: selectedMedia!,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

/*import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageVideoPickerController extends GetxController {
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

class ImageVideoPickerDemo extends StatelessWidget {
  const ImageVideoPickerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageVideoPickerController>(
      init: ImageVideoPickerController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Pick image and video from gallery"),
            backgroundColor: Colors.deepPurple.shade100,
          ),
          body: Center(
            child: GestureDetector(
              onTap: controller.pickMedia,
              child: controller.selectedMedia == null
                  ? DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(16),
                      color: Colors.black.withOpacity(0.16),
                      strokeWidth: 2,
                      dashPattern: const [3, 3, 3, 3],
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: const Padding(
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
                      radius: const Radius.circular(16),
                      color: Colors.black.withOpacity(0.16),
                      strokeWidth: 2,
                      dashPattern: const [3, 3, 3, 3],
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: SizedBox(
                          height: 400,
                          child: MediaProvider(
                            media: controller.selectedMedia!,
                          ),
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
*/