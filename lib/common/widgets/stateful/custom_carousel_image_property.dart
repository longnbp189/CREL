import 'package:cached_network_image/cached_network_image.dart';
import 'package:crel_mobile/common/widgets/stateful/custom_carousel.dart';
import 'package:crel_mobile/config/app_color.dart';
import 'package:crel_mobile/config/text_style.dart';
import 'package:crel_mobile/models/media.dart';
import 'package:flutter/material.dart';

class CustomCarouselImageProperty extends StatefulWidget {
  final List<Media>? media;

  const CustomCarouselImageProperty({Key? key, required this.media})
      : super(key: key);

  @override
  _CustomCarouselImagePropertyState createState() =>
      _CustomCarouselImagePropertyState();
}

class _CustomCarouselImagePropertyState
    extends State<CustomCarouselImageProperty> {
  late PageController _pageController;
  int _position = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            // boxShadow: Box,
            border: Border(
          bottom: BorderSide(
            //                   <--- left side
            color: Colors.black,
            width: 1,
          ),
        )),
        height: 250,
        child: (widget.media != null && widget.media!.isNotEmpty)
            ? Stack(
                children: [
                  SizedBox(
                    height: 250,
                    child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.media!.length,
                        onPageChanged: (int position) {
                          setState(() {
                            _position = position;
                          });
                        },
                        itemBuilder: (BuildContext context, int position) {
                          return imageSlider(position);
                        }),
                  ),
                  (widget.media!.length == 1)
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: AnimatedPageIndicatorFb1(
                              currentPage: _position,
                              numPages: widget.media!.length,
                              gradient: const LinearGradient(colors: [
                                AppColor.primaryColor,
                                AppColor.primaryColor,
                                // AppColor.primaryColor.withOpacity(0.8),
                                // Colors.blue.withOpacity(0.4),
                                // Colors.blue.withOpacity(0.8),
                              ]),
                              activeGradient: const LinearGradient(colors: [
                                AppColor.primaryColor,
                                AppColor.primaryColor,
                                // AppColor.primaryColor.withOpacity(0.8),
                              ]),
                            ),
                          ),
                        ),
                ],
              )
            : const Center(
                child: Text(
                  "Không có ảnh",
                  style: TxtStyle.heading2,
                ),
              ));
  }

  Widget imageSlider(int position) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, widget) {
        return widget!;
      },
      child: Container(
        child: CardFb1(imageUrl: widget.media![position].link!),
      ),
      // child: Container(
      //     // child: cards[position],
      //     width: 200,
      //     height: 200,
      //     // padding: const EdgeInsets.all(30.0),
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(12.5),
      //       boxShadow: [
      //         BoxShadow(
      //             offset: const Offset(10, 20),
      //             blurRadius: 10,
      //             spreadRadius: 0,
      //             color: Colors.grey.withOpacity(.05)),
      //       ],
      //     ),
      //     child: cards[position]),
    );
  }
}

class CardFb1 extends StatelessWidget {
  final String imageUrl;

  const CardFb1({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
      // height: 300,
      // padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.5),
        boxShadow: [
          BoxShadow(
              offset: const Offset(10, 20),
              blurRadius: 10,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.05)),
        ],
      ),
      // child: PhotoView(
      //   f
      //   imageProvider: CachedNetworkImageProvider(imageUrl,) Image.network(imageUrl, fit: BoxFit.cover),
      //    ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ImageScreen(
              imageUrl: imageUrl,
            );
          }));
        },
        child: Hero(
          tag: 'imageHero',
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imageUrl,
          ),
        ),
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String imageUrl;
  const ImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: imageUrl,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
