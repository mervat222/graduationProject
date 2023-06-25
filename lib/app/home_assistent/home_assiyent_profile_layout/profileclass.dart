import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfileClass extends StatelessWidget {
  String imageicon;
  String data;
  int i;
  ProfileClass(this.imageicon, this.data, this.i, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              ImageIcon(
                AssetImage(imageicon),
                color: const Color.fromRGBO(0, 0, 0, 0.8),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(data)
            ],
          ),
          i == 5
              ? Container()
              : const Divider(
                  color: Colors.grey,
                  thickness: .3,
                )
        ],
      ),
    );
  }
}
