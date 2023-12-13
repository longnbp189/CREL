import 'dart:io';

import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/profile/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AvatarProfile extends StatefulWidget {
  const AvatarProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final Broker user;

  @override
  State<AvatarProfile> createState() => _AvatarProfileState();
}

class _AvatarProfileState extends State<AvatarProfile> {
  File? image;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    Future.delayed(const Duration(seconds: 1));
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        BlocProvider.of<ProfileBloc>(context).add(UpdateAvatar(image!));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => getImage(),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: Colors.grey[300],
            image: DecorationImage(
                image: (image != null)
                    ? FileImage(image!)
                    : widget.user.avatarLink == null
                        ? const NetworkImage(
                            "https://static.wikia.nocookie.net/bleach/images/1/16/Hitsugayatoshiro.png/revision/latest?cb=20111020043210&path-prefix=vi")
                        : NetworkImage(widget.user.avatarLink!.toString())
                            as ImageProvider,
                fit: BoxFit.cover)),
      ),

      //  Avatar(
      //   avatarUrl:

      //   widget.user.avatarLink!,
      //   sizeAvatar: 120,
      // ),
    );
  }
}
