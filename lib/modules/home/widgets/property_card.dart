import 'package:cached_network_image/cached_network_image.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    Key? key,
    required this.size,
    required this.propertyForRent,
  }) : super(key: key);

  final Size size;
  final Property propertyForRent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: size.width,
        // decoration: const BoxDecoration(
        //   boxShadow: [
        //     BoxShadow(
        //       color: AppColor.textColor,
        //       blurRadius: 10,
        //       offset: Offset(5, 5),
        //     ),
        //   ],
        // ),
        child: Card(
          color: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: CachedNetworkImage(
                  height: size.height / 4.55,
                  width: size.width,
                  fit: BoxFit.cover,
                  imageUrl: (propertyForRent.media!.isNotEmpty)
                      ? propertyForRent.media![0].link.toString()
                      : "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   width: size.width,
                    //   child: Text(
                    //     propertyForRent.id!.toString(),
                    //     overflow: TextOverflow.ellipsis,
                    //     maxLines: 1,
                    //     style: TxtStyle.heading3.copyWith(color: Colors.white),
                    //   ),
                    // ),
                    SizedBox(
                      width: size.width,
                      child: Text(
                        propertyForRent.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TxtStyle.heading3.copyWith(color: Colors.white),
                      ),
                    ),
                    // SizedBox(
                    //   width: size.width,
                    //   child: Text(
                    //     propertyForRent.getQuillDescription()!,
                    //     // propertyForRent.description!,
                    //     overflow: TextOverflow.ellipsis,
                    //     maxLines: 1,
                    //     style: TxtStyle.heading3.copyWith(color: Colors.white),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      propertyForRent.location!.address.toString() +
                          ", " +
                          propertyForRent.location!.ward!.name.toString() +
                          ", " +
                          propertyForRent.location!.ward!.district!.name
                              .toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TxtStyle.heading5Blue.copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          // propertyForRent.floorArea.toString().contains(".0")
                          //     ? propertyForRent.floorArea!.toInt().toString() +
                          //         " m\u00B2"
                          //     : propertyForRent.floorArea.toString() +
                          //         " m\u00B2",
                          AppFormat.changeMeterVN(
                                  propertyForRent.floorArea.toString()) +
                              " m\u00B2",
                          style: TxtStyle.heading5Blue
                              .copyWith(color: Colors.white),
                        )),
                        Text(
                          AppFormat.changePriceVN(
                                  propertyForRent.price.toString()) +
                              " Triệu / tháng",
                          style: TxtStyle.heading5Blue
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
