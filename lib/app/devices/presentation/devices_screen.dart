import 'package:cord_2/app/devices/presentation/updateName.dart';
import 'package:cord_2/app/devices/presentation/verify_code.dart';
import 'package:cord_2/core/components/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/components/loading_effect.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utils/navigator.dart';
import '../../layout/presentation/cord_layout.dart';
import '../cubit/devices_cubit.dart';
import 'connect.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DevicesCubit()
        ..token()
        ..getSensorData(),
      child: BlocConsumer<DevicesCubit, DevicesState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DevicesCubit.get(context);
          return FutureBuilder(
              future: cubit.getSensorData(),
              builder: (c, s) {
                return s.data == null
                    ? MyShimmer(
                        MediaQuery.of(context).size.height / 1.4.toDouble())
                    : s.data!.isEmpty
                        ? const Connect()
                        : Scaffold(
                            appBar: PreferredSize(
                              preferredSize: Size.fromHeight(55.h),
                              child: AppBar(
                                centerTitle: true,
                                leading: IconButton(
                                    onPressed: () {
                                      DevicesCubit.listOfDevices.isEmpty
                                          ? Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                              return const VerifyWithCode();
                                            }))
                                          : ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Please Disconnect current device')));
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 25,
                                    )),
                                backgroundColor: AppColors.kWhite,
                                title: Text(
                                  'Devices',
                                  style: TextStyle(
                                    color: AppColors.kBlack,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            body: Container(
                                padding: const EdgeInsets.only(
                                    top: 12, bottom: 12, left: 12),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Device Connected:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Noto Sans"),
                                    ),
                                    Divider(),
                                    CustomListview(),
                                  ],
                                )),
                          );
              });
        },
      ),
    );
  }
}

class CustomListview extends StatelessWidget {
  const CustomListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DevicesCubit()..token(),
      child: BlocConsumer<DevicesCubit, DevicesState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DevicesCubit.get(context);
          return FutureBuilder(
              future: cubit.getSensorData(),
              builder: (c, s) {
                return Expanded(
                  child: s.data == null
                      ? MyShimmer(
                          MediaQuery.of(context).size.height / 2.toDouble())
                      : ListView.builder(
                          itemCount: s.data!.length,
                          itemBuilder: (c, i) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    s.data == null
                                        ? 'wait...'
                                        : s.data![i]['name'].toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      DevicesCubit.deviceIndex = i;
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const CustomAlertDialog();
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.more_vert)),
                              ],
                            );
                          }),
                );
              });
        },
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DevicesCubit(),
      child: BlocConsumer<DevicesCubit, DevicesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = DevicesCubit.get(context);
          return AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              elevation: 0.0,
              // title: Center(child: Text("Evaluation our APP")),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            navigateAndFinish(context, const UpdateName());
                          },
                          child: const Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              ImageIcon(
                                AssetImage('assets/icons/edit_name.png'),
                                color: Color.fromRGBO(130, 128, 240, 1),
                                size: 14,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Edit Name')
                            ],
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            cubit.deleteSensor(context);
                            navigateAndFinish(context, const CordLayout());
                          },
                          child: const Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              ImageIcon(
                                AssetImage('assets/icons/Disconnect.png'),
                                color: Color.fromRGBO(130, 128, 240, 1),
                                size: 14,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Disconnect')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GradientButton(title: 'Cancel', onPressed: (){
                    Navigator.pop(context);
                  })
                ],
              ));
        },
      ),
    );
  }
}
