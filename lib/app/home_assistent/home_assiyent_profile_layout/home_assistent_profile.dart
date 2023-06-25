import 'package:cord_2/app/home_assistent/home_assiyent_profile_layout/profileclass.dart';
import 'package:cord_2/core/components/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/variables.dart';
import '../../profile/cubit/PatientProile_cubit.dart';
import '../../profile/patiant_profile_layout/editprofile.dart';
import '../../profile/patiant_profile_layout/patint_appbar.dart';
import '../../signup/presentation/signup_screen.dart';
import 'language_setting.dart';

class AssistantProfile extends StatelessWidget {
  const AssistantProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PatientProileCubit()..token(),
        child: BlocConsumer<PatientProileCubit, PatientProileState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = PatientProileCubit.get(context);
              return Scaffold(
                appBar: HomeAssistentAppBar('Profile'),
                body: Container(
                  padding: const EdgeInsets.only(
                      bottom: 170, left: 15, right: 15, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color.fromRGBO(0, 129, 207, 1),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage:
                          AssetImage('assets/icons/Avatar.png'),
                        ),
                      ),
                      FutureBuilder(
                          future: cubit.getData('name'),
                          builder: (c, s) {
                            return Text(
                              s.data == null ? 'wait...' : s.data.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            );
                          }),
                      FutureBuilder(
                          future: cubit.getData('email'),
                          builder: (c, s) {
                            return Text(
                              s.data == null ? 'wait...' : s.data.toString(),
                              style: const TextStyle(),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GradientButton(
                          height: 45.h,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (c) {
                                  return EditProfile();
                                }));
                          },
                          title: 'Edit Profile',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: Variables().data2.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                    onTap: () {
                      index == 0
                          ? Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                              return const LanguageSetting();
                            }))
                          : null;
                       index == 3
                      ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (c) {
                      return SignUpScreen();
                      }), (route) => false)
                          : null;
                    },
                    child: ProfileClass(Variables().iconimage2[index],
                        Variables().data2[index], index),
                  );
                })
                          ,
                    ],
                  ),
                ),
              );
            }));
  }
}
