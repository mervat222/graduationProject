import 'package:flutter/material.dart';
import 'home_appbar.dart';

class HomeWithoutDevice extends StatelessWidget {
  const HomeWithoutDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeWithout_devices_AppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Expanded(
                flex: 3, child: Image.asset('assets/images/no_devices.png')),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'No Device Connected',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Go to "Devices" section \n and connect your Device to app',
              textAlign: TextAlign.center,
            ),
            Container(
                padding: EdgeInsets.only(
                    top: 100, right: MediaQuery.of(context).size.width / 4),
                child: const Icon(
                  Icons.keyboard_double_arrow_down_outlined,
                  size: 40,
                ))
          ],
        ),
      ),
    );
  }
}
