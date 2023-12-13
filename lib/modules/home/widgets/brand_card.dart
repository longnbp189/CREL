import 'package:cached_network_image/cached_network_image.dart';
import 'package:crel_mobile/common/widgets/stateless/container_boder.dart';
import 'package:crel_mobile/config/app_color.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/text_style.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    Key? key,
    required this.size,
    required this.brand,
  }) : super(key: key);

  final Size size;
  final Brand brand;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ContainerBoder(
          colorWidth: AppColor.boderColor,
          boder: 10,
          colorContainer: Colors.white,
          // width: size.width,

          // height: 100,
          // decoration: const BoxDecoration(color: Colors.amber),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16, left: 16, top: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   brand.id.toString(),
                      //   style: TxtStyle.heading3,
                      // ),
                      Text(
                        brand.name.toString(),
                        style: TxtStyle.heading3,
                      ),

                      // const SizedBox(
                      //   height: 8,
                      // ),

                      // Text(
                      //   brand.email.toString(),
                      //   style: TxtStyle.heading4,
                      //   maxLines: 2,
                      //   overflow: TextOverflow.ellipsis,
                      // ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        AppFormat.phoneFormat(brand.phoneNumber.toString()),
                        style: TxtStyle.heading4,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        AppFormat.parseHtmlString(brand.description.toString()),
                        style: TxtStyle.heading4,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Row(
                      //   children: [
                      //     const FaIcon(
                      //       FontAwesomeIcons.store,
                      //       size: 20,
                      //     ),
                      //     const SizedBox(width: 4),
                      //     Text(
                      //       brand.stores!.isEmpty
                      //           ? "0 cửa hàng"
                      //           : brand.stores!.length.toString() + " cửa hàng",
                      //       style: TxtStyle.heading4,
                      //     )
                      //   ],
                      // )
                      // Text(
                      //   brand.name.toString(),
                      //   style: TxtStyle.heading1,
                      // )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          height: 120,
                          imageUrl: brand.avatarLink ??
                              "https://cdn-www.vinid.net/824ff0bb-1-kv-1920x1080-1.jpg",
                        ),
                      ),
                    ),
                    Container(
                      height: 120,
                      width: 80,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          gradient: LinearGradient(
                        // begin: Alignment.,
                        // end: Alignment.bottomLeft,
                        colors: [
                          Colors.white,
                          Colors.white.withOpacity(0),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
