import 'package:crel_mobile/common/widgets/stateless/avatar.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenberInfo extends StatefulWidget {
  final Broker user;

  const MenberInfo({Key? key, required this.user}) : super(key: key);

  @override
  State<MenberInfo> createState() => _MenberInfoState();
}

class _MenberInfoState extends State<MenberInfo> {
  String? id;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      prefs = sp;
      id = prefs!.getString('id');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51,
      width: AppFormat.width(context),
      child: ElevatedButton(
        style: TxtStyle.buttonGray.copyWith(),
        onPressed: () {
          // Navigator.pushNamed(context, AppRouter.editProfile);
        },
        child: Row(
          children: [
            Avatar(
              avatarUrl: widget.user.avatarLink!,
              sizeAvatar: 35,
            ),
            const SizedBox(
              width: 16,
            ),
            (widget.user.id!.toString() == id.toString())
                // (widget.user.id!.toString().contains("3"))
                ? Text(
                    widget.user.name! + " (Bạn)",
                    style: TxtStyle.heading4,
                  )
                : Text(
                    widget.user.name!,
                    style: TxtStyle.heading4,
                  )
          ],
        ),
      ),
    );
  }
}
