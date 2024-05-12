import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/src/view/widget/global_members.dart';
import 'package:flutter/material.dart';

class SenderRowView extends StatelessWidget {
  const SenderRowView({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
      ),
      visualDensity: VisualDensity.comfortable,
      title: Wrap(alignment: WrapAlignment.end, children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColor.lightOrange,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            chatModelList.elementAt(index).message,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.white),
            softWrap: true,
          ),
        ),
      ]),
      subtitle: const Padding(
        padding: EdgeInsets.only(right: 8, top: 4),
        child: Text(
          '10:03 AM',
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 10),
        ),
      ),
      trailing: const CircleAvatar(
        backgroundImage: AssetImage("assets/images/profile_pic.png"),
      ),
    );
  }
}
