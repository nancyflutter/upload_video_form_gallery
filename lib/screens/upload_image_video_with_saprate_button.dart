// UPLOAD IMAGE OR VIDEO WITH BUTTON's CLICK
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

// home: const MediaPickerScreen(),

class MediaPickerScreen extends StatefulWidget {
  const MediaPickerScreen({super.key});

  @override
  State<MediaPickerScreen> createState() => _MediaPickerScreenState();
}

class _MediaPickerScreenState extends State<MediaPickerScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile?> _mediaFiles = [];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _mediaFiles.add(image);
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _mediaFiles.add(video);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Picker'),
      ),
      body: Column(
        children: [
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image from Gallery'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _pickVideo,
                child: const Text('Pick Video from Gallery'),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.0,
                  mainAxisExtent: 600,
                ),
                itemCount: _mediaFiles.length,
                itemBuilder: (BuildContext context, int index) {
                  final file = _mediaFiles[index];
                  if (file != null) {
                    if (file.path.toLowerCase().endsWith('.mp4')) {
                      return VideoItem(video: file);
                    } else {
                      return ImageItem(image: file);
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  final XFile image;

  const ImageItem({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(image.path),
      fit: BoxFit.cover,
    );
  }
}

class VideoItem extends StatefulWidget {
  final XFile video;

  const VideoItem({super.key, required this.video});

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.video.path))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playVideo() {
    _controller.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('Video Info: ${_controller.value}');
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: () {
              _playVideo();
            },
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
