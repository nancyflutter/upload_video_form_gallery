// MULTIPLE IMAGE AND VIDEO ARE PICKED AND UPLOADED FROM GALLERY

import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';

class MyHomePage extends StatefulWidget {
  final List<MediaFile>? medias;
  final String title;

  const MyHomePage({
    super.key,
    required this.title,
    this.medias,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MediaFile> selectedMedias = [];

  @override
  void initState() {
    if (widget.medias != null) {
      selectedMedias = widget.medias!;
    }
    super.initState();
  }

  int pageIndex = 0;
  var controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            const Text(
              'These are your selected medias',
            ),
            const Divider(),
            Expanded(
              flex: 5,
              child: Stack(children: [
                if (selectedMedias.isNotEmpty)
                  PageView(
                    controller: controller,
                    children: [
                      for (var media in selectedMedias)
                        Center(
                          child: MediaProvider(
                            media: media,
                          ),
                        )
                    ],
                  ),
                if (selectedMedias.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          if (pageIndex < selectedMedias.length - 1) {
                            pageIndex++;
                            controller.animateToPage(pageIndex,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                            setState(() {});
                          }
                        },
                        child: const Icon(
                          Icons.chevron_right,
                          size: 40,
                          color: Colors.red,
                        )),
                  ),
                if (selectedMedias.isNotEmpty)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () {
                          if (pageIndex > 0) {
                            pageIndex--;
                            controller.animateToPage(pageIndex,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                            setState(() {});
                          }
                        },
                        child: const Icon(
                          Icons.chevron_left,
                          size: 40,
                          color: Colors.red,
                        )),
                  ),
              ]),
            ),
            SizedBox(
              height: 65,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 0; i < selectedMedias.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextButton(
                        onPressed: () {
                          pageIndex = i;
                          controller.animateToPage(pageIndex,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                          setState(() {});
                        },
                        child: Container(
                            width: 65,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: pageIndex == i
                                        ? Colors.red
                                        : Colors.black)),
                            child: ThumbnailMedia(
                              media: selectedMedias[i],
                            )),
                      ),
                    )
                ],
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickMedia,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> pickMedia() async {
    List<MediaFile>? media = await GalleryPicker.pickMedia(
      context: context,
      initSelectedMedia: selectedMedias,
      startWithRecent: true,
    );

    if (media != null) {
      setState(() {
        // Update the list with newly picked files only
        selectedMedias = media;
      });
    }
  }

  pickMediaWithBuilder() {
    GalleryPicker.pickMediaWithBuilder(
      heroBuilder: (tag, media, context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Hero Page'),
          ),
          body: Center(
            child: Hero(
              tag: tag,
              child: MediaProvider(
                media: media,
                width: MediaQuery.of(context).size.width - 50,
                height: 300,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              GalleryPicker.dispose();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(
                    title: "Selected Medias",
                    medias: [media],
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        );
      },
      context: context,
      multipleMediaBuilder: (List<MediaFile> media, BuildContext context) {
        return Container();
      },
    );
  }
/*

  Future<void> getGalleryMedia() async {
    GalleryMedia? allmedia =
        await GalleryPicker.collectGallery(locale: const Locale("tr"));
  }
*/
}
